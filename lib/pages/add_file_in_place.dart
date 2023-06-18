import 'dart:io';
import 'package:clg_mat/constants/const_colors.dart';
import 'package:clg_mat/widgets/alert_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../models/file_model.dart';

class AddFileInPlace extends StatefulWidget {

  String uid;
  String placeId;
  AddFileInPlace({
    required this.uid,
    required this.placeId
});

  @override
  State<AddFileInPlace> createState() => _AddFileInPlaceState();
}

class _AddFileInPlaceState extends State<AddFileInPlace> {

  TextEditingController fileName = TextEditingController();
  TextEditingController fileAbout = TextEditingController();
  File? selectedFile;


  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
      )
    );

    return Scaffold(
      body: SafeArea(

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //app bar
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    IconButton(
                        onPressed: (){
                          Navigator.popUntil(context, (route) => route.isFirst);
                        },
                        icon: FaIcon(FontAwesomeIcons.close)
                    ),

                    // //Title
                    // Text("Add file",style: TextStyle(
                    //   fontSize: 20,
                    //     fontWeight: FontWeight.bold,
                    //     color: Colors.black
                    // ),),

                    //save btn
                    InkWell(
                      onTap: (){
                        if(selectedFile!=null){
                          doneFunc();
                        }else {
                          AlertMessage(context, Text("please select any file"));
                        }
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                          decoration: BoxDecoration(
                            color: ConstColor.mainColor,
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                          child: Text("Done",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                            ),
                          )
                      ),
                    )
                  ],
                ),
              ),



              //file title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  autofocus: true,
                  controller: fileName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                  maxLines: 1,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Name",

                  ),

                ),
              ),
              // file about section
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: fileAbout,
                      maxLines: 50,
                      // expands: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "What's in this?",

                      ),
                    ),
                  ),
              ),

              //add file and link option
              Row(
                children: [
                  //file icon
                  iconBtn(
                          () {
                            selectDocument();
                          },
                      MdiIcons.fileDocumentOutline
                  ),

                  //link icon
                  // iconBtn(
                  //         () {
                  //           AlertMessage(context, Text("Past your file"));
                  //         }
                  //     ,MdiIcons.linkBoxVariantOutline
                  // ),

                  // add link
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.black12,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Add link"
                          ),
                        ),
                      ),
                    ),
                  )

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


  //add function to add document in place
  selectDocument()async{
    FilePickerResult?  filePickerResult = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type:FileType.any
    );

    PlatformFile file = filePickerResult!.files.first;

    if(file == null){
      return
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content:Text("Please select any one file"))
        );
    }

    if(file.extension == "pdf"||
        file.extension =="doc" ||
        file.extension =="docx"
    ){
      this.selectedFile = File(file.path!);


    }else{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content:Text("Wrong file type"))
      );
    }
  }

  doneFunc(){
    Future uploading = uploadTask(selectedFile);

    //while uploading task run show loading indicator
    showDialog(
        context: context,
        builder:(context){
          uploading.whenComplete(() => Navigator.pop(context));
          return Center(
            child: CircularProgressIndicator(),
          );
        }
    );

  }



  Future uploadTask(File? file)async {

    DateTime fileCreatedOn = DateTime.now();
    String fileId = widget.uid + (fileCreatedOn.toString());
    FileModel fileModel = new FileModel(
      fileId: fileId,
      fileTitle: fileName.text.trim(),
      fileDescription: fileAbout.text.trim(),
      fileCreatedOn: fileCreatedOn,
    );


    try {
      //file uploading
      Reference ref = FirebaseStorage.instance.ref().child("files").child(
          fileId);

      await ref.putFile(file!);

      await ref.getDownloadURL().then((ds) => fileModel.fileUrl = ds);

      //set file model
      await FirebaseFirestore.instance.collection("files").doc
        (fileId).set(fileModel.toMap());

      //add fileId in users model - fileList
      List? fileList;
      await FirebaseFirestore.instance.collection("places")
          .doc(widget.placeId)
          .get()
          .then((ds) {
        fileList = ds.data()!["fileList"];
        if (fileList == null) {
          fileList = [fileId];
        } else {
          fileList!.add(fileId);
        }
      });

      await FirebaseFirestore.instance.collection("places")
          .doc(widget.placeId)
          .update({
        "fileList": fileList
      });
      setState(() {

      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Wrong file type"))
      );
    }

  }

  Widget iconBtn(VoidCallback onPressed, IconData icons){
    return IconButton(
        onPressed: onPressed,
      icon: Icon(icons,size: 30,),
      color: ConstColor.mainColor,

    );
  }




}
