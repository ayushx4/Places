import 'dart:developer';
import 'dart:io';
import 'package:clg_mat/models/users_places_detail.dart';
import 'package:clg_mat/pages/home/home_page.dart';
import 'package:clg_mat/widgets/alert_message.dart';
import 'package:clg_mat/widgets/btn.dart';
import 'package:clg_mat/widgets/custom_input_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../constants/const_colors.dart';
import '../../../models/user_model.dart';

class BasicDetail extends StatefulWidget {

  UserModel userModel;
  File? profileImage;
  int avatar;


  BasicDetail({
    required this.userModel,
    required this.avatar,
    this.profileImage,

  });

  @override
  State<BasicDetail> createState() => _BasicDetailState();
}

class _BasicDetailState extends State<BasicDetail> {

  var usernameController = TextEditingController();
  var aboutUserController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: ConstColor.mainColorL2,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: ConstColor.mainColorL2,
        )
    );

    return Scaffold(
      resizeToAvoidBottomInset : false,
      backgroundColor: ConstColor.mainColorL2,
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


              //username
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: CustomInputFeild(
                    controller: usernameController,
                    isPassword: false,
                    label: "Nick name"
                ),
              ),
              

              //bio
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 100,
                  ),
                  child: CustomInputFeild(
                    controller: aboutUserController,
                    maxLine: 8,
                    isPassword: false,
                    label: "Describe your self",
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Btn(
                  onTap: (){
                    createProfile();
                  },

                    text: "Create Profile",
                    textStyle: const TextStyle(color: Colors.white),
                    btnColor: ConstColor.mainColor,
                    btnWidth: MediaQuery.of(context).size.width,
                    btnShadow: const[
                    BoxShadow(
                      color: ConstColor.mainColorL1,
                      offset: Offset(5,5),
                    )
                  ]
                ),
              ),




            ],

        )

        )

        ),

    );
  }


  createProfile()async {
    log("entering crete profile block of code////////////////////////");

    if (usernameController != null) {

      if(widget.avatar==0){
        uploadTask();
      }

      UserModel userModel=widget.userModel;
      userModel.createdOn=DateTime.timestamp();
      userModel.userName=usernameController.text.trim();
      userModel.aboutUser=aboutUserController.text.trim();
      userModel.avatar = widget.avatar;

      try {
        await FirebaseFirestore.instance.collection("users")
            .doc(widget.userModel.uid).set(widget.userModel.toMap());
      } catch (error) {
        AlertMessage(context , Text(error.toString()));
      }
      
      UsersPlacesDetail usersPlacesDetail = UsersPlacesDetail(
        uid: widget.userModel.uid,
        placesList: null
      );

      try{
        await FirebaseFirestore.instance.collection("usersPlacesDetail")
                  .doc(widget.userModel.uid).set(usersPlacesDetail.toMap());
      }catch(error){
        AlertMessage(context, Text(error.toString()));
      }

      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>
              HomePage(uid: widget.userModel.uid.toString()))
      );
    } else {
      AlertMessage(context ,Text("Please enter username"));
    }
  }



  uploadTask()async{

    if(widget.profileImage!=null){
      Reference storageReference = FirebaseStorage.instance
          .ref().child("profile_pictures").child(widget.userModel.uid.toString());

      await storageReference.putFile(widget.profileImage!);

      AlertMessage(context, Text("Nice Profile pic"));


     await storageReference.getDownloadURL().then(
              (imageUrl) async{
            widget.userModel.profilePic = imageUrl;
          }
      );
    }
  }





}


