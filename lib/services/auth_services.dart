import 'package:clg_mat/models/user_model.dart';
import 'package:clg_mat/pages/authentication/profile/basic_detail.dart';
import 'package:clg_mat/pages/home/home_page.dart';
import 'package:clg_mat/widgets/alert_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthServices{

  final FirebaseAuth _auth = FirebaseAuth.instance ;

  Future signInWithMail(String email, String password,context) async {
    UserCredential? credential;
    

    try{

      credential = await _auth.
      createUserWithEmailAndPassword(email: email, password: password);

      String uid = credential.user!.uid;

      UserModel newUser = UserModel(
        uid: uid,
        mailId: email,
      );

      await FirebaseFirestore.instance.collection("users")
          .doc(uid).set(newUser.toMap());

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => BasicDetail(userModel: newUser)
          ));
    } catch(error){
      AlertMessage(Text(error.toString()), context);
    }
  }


  Future LogInWithMail(String email,String password , context) async{

    UserCredential? credential;

    try{

      credential = await _auth.
      signInWithEmailAndPassword(email: email, password: password);
      
      String uid = credential.user!.uid;

      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder:(context)=>HomePage(uid: uid)
        ));

    } catch(error){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.toString()))
      );
    }


    


  }

}