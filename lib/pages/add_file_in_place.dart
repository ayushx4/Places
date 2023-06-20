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
import 'package:uuid/uuid.dart';

import '../models/file_model.dart';

class AddFileInPlace extends StatefulWidget {
  String uid;
  String placeId;
  AddFileInPlace({required this.uid, required this.placeId});

  @override
  State<AddFileInPlace> createState() => _AddFileInPlaceState();
}

class _AddFileInPlaceState extends State<AddFileInPlace> {
  TextEditingController fileName = TextEditingController();
  TextEditingController fileAbout = TextEditingController();
  File? selectedFile;
  TextEditingController linkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: ConstColor.SCWhite,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: ConstColor.SCWhite,
    ));

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //app bar
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.popUntil(context, (route) => route.isFirst);
                        },
                        icon: FaIcon(FontAwesomeIcons.close)),

                    //done btn
                    InkWell(
                      onTap: () {
                        if (selectedFile != null || linkController.text != "") {
                          doneFunc();
                        } else {
                          AlertMessage(context,
                              Text("please select any file or add url"));
                        }
                      },
                      child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: ConstColor.mainColor,
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                          child: Text(
                            "Done",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )),
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
                  iconBtn(() {
                    selectDocument();
                  }, MdiIcons.fileDocumentOutline),

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
                          controller: linkController,
                          decoration: InputDecoration(
                              border: InputBorder.none, hintText: "Add link"),
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
  selectDocument() async {
    FilePickerResult? filePickerResult = await FilePicker.platform
        .pickFiles(allowMultiple: false, type: FileType.any);

    PlatformFile file = filePickerResult!.files.first;

    if (file == null) {
      return ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please select any one file")));
    }

    if (file.extension == "pdf" ||
        file.extension == "doc" ||
        file.extension == "docx") {
      this.selectedFile = File(file.path!);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Wrong file type")));
    }
  }

  doneFunc() {
    Future uploading = uploadTask(selectedFile);

    //while uploading task run show loading indicator
    showDialog(
        context: context,
        builder: (context) {
          uploading.whenComplete(() => Navigator.popUntil(context, (route) => route.isFirst));
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Future uploadTask(File? file) async {
    DateTime fileCreatedOn = DateTime.now();
    String fileId = widget.uid + (fileCreatedOn.toString());
    String docId = widget.uid + (Uuid().v4());
    FileModel fileModel = new FileModel(
      fileId: fileId,
      fileName: fileName.text.trim(),
      docId: docId,
      attachedLink: linkController.text.trim(),
      fileDescription: fileAbout.text.trim(),
      fileCreatedOn: fileCreatedOn,
    );

    try {
      if (selectedFile != null) {
        //Doc uploading
        Reference ref =
            FirebaseStorage.instance.ref().child("files").child(docId);

        await ref.putFile(file!);

        await ref.getDownloadURL().then((ds) => fileModel.docLinkW = ds);
      }

      //set file model
      await FirebaseFirestore.instance
          .collection("files")
          .doc(fileId)
          .set(fileModel.toMap());

      //add fileId in users model - fileList
      List? fileList;
      await FirebaseFirestore.instance
          .collection("places")
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

      await FirebaseFirestore.instance
          .collection("places")
          .doc(widget.placeId)
          .update({"fileList": fileList});
      setState(() {});
    } catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Wrong file type")));
    }
  }

  Widget iconBtn(VoidCallback onPressed, IconData icons) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icons,
        size: 30,
      ),
      color: ConstColor.mainColor,
    );
  }
}
