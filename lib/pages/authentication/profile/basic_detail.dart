import 'dart:developer';
import 'dart:io';

import 'package:clg_mat/pages/home/home_page.dart';
import 'package:clg_mat/widgets/alert_message.dart';
import 'package:clg_mat/widgets/btn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/user_model.dart';

class BasicDetail extends StatefulWidget {

  UserModel userModel;

  BasicDetail({required this.userModel});

  @override
  State<BasicDetail> createState() => _BasicDetailState();
}

class _BasicDetailState extends State<BasicDetail> {

  var usernameController = TextEditingController();
  var bioController = TextEditingController();
  File? profileImage;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              //back button

              //title
              const Text("Profile",style: TextStyle(fontSize: 20),),
              const SizedBox(height: 20,),

              //profile pic
              Container(
                height: 200,
                width: 200,
                child: Stack(
                  children: [
                    SizedBox(
                        height : 200,
                        width: 200,
                        child: CircleAvatar(
                          backgroundImage: (profileImage!=null) ? FileImage(profileImage!) : null,
                        )
                    ),
                    
                    Positioned(
                      width: 50,
                        height: 50,
                        top: 5,
                        right: 5,
                        child:GestureDetector(
                          onTap: ()async{
                            selectImage();
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.indigo,
                              borderRadius: BorderRadius.all(Radius.circular(50)),
                            ),
                            child: const Center(
                              child: Icon(Icons.edit,color: Colors.white,),
                            ),
                          ),
                        )
                    ),
                  ]
              ),
        ),



              SizedBox(height: 15,),

              //username
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  label: Text("Username"),
                ),
              ),
              SizedBox(height: 15,),

              //bio
              TextField(
                controller: bioController,
                decoration: InputDecoration(
                  label: Text("Bio"),
                ),
              ),

              Btn(
                  text: "Create Profile",
                onTap: (){
                  createProfile();
                },
              ),








            ],

        )

        )

        ),

    );
  }



  Future selectImage()async{

    XFile? imageFile;
    imageFile = await ImagePicker().pickImage(source: ImageSource.gallery,) ;
    Navigator.popUntil(context, (route) => route.isFirst);
    print(imageFile.toString());

    if(imageFile==null){
      AlertMessage(Text("Someting want wrong"), context);
    }else{
      final tempImage = File(imageFile!.path);
      // CroppedFile? croppedFile = await ImageCropper().cropImage(sourcePath: imageFile!.path);
      setState(() {
        this.profileImage = tempImage;
      });

    }
    
  }

  createProfile()async {
    log("entering crete profile block of code////////////////////////");

    if (usernameController != null) {
      uploadTask();

      try {
        await FirebaseFirestore.instance.collection("users")
            .doc(widget.userModel.uid).set(widget.userModel.toMap());
      } catch (error) {
        AlertMessage(Text(error.toString()), context);
      }

      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>
              HomePage(uid: widget.userModel.uid.toString()))
      );
    } else {
      AlertMessage(Text("Please enter username"), context);
    }
  }



  uploadTask()async{
    if(profileImage!=null){
      Reference storageReference = FirebaseStorage.instance
          .ref().child("profile_pictures").child(widget.userModel.uid.toString());

      await storageReference.putFile(profileImage!);

      AlertMessage(Text("Nice Profile pic"), context);


      storageReference.getDownloadURL().then(
              (imageUrl) async{
            widget.userModel.profilePic = imageUrl;
          }
      );
    }
  }





}


