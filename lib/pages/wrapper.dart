import 'package:clg_mat/models/user_model.dart';
import 'package:clg_mat/pages/authentication/login_page.dart';
import 'package:flutter/material.dart';

import 'authentication/signup_page.dart';
import 'home/home_page.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel userModel = UserModel(uid: "abc1234");
    // test1 uid = "nfDEw63SVUNzkdWF5ABjvUEGAc92"
    //mail id = test1@gmail.com  pass 123456
    // profile pic = "https://firebasestorage.googleapis.com/v0/b/places-df5ef.appspot.com/o/profile_pictures%2FnfDEw63SVUNzkdWF5ABjvUEGAc92?alt=media&token=ff435165-e909-48aa-bf3e-c5325a5facf1"
    // return HomePage(uid: "nfDEw63SVUNzkdWF5ABjvUEGAc92");
    return LoginPage();
  }
}
