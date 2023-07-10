import 'package:clg_mat/models/user_model.dart';
import 'package:clg_mat/pages/authentication/login_page.dart';
import 'package:clg_mat/pages/authentication/profile/choose_profilepic.dart';
import 'package:clg_mat/pages/splash_screen.dart';
import 'package:flutter/material.dart';

import 'authentication/signup_page.dart';
import 'home/home_page.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel userModel = UserModel(uid: "s6BWxaZKIQNzcyxKA4I6Nr4zc222");
    // test_user1 uid = "nfDEw63SVUNzkdWF5ABjvUEGAc92"
    // test_user2 uid = "s6BWxaZKIQNzcyxKA4I6Nr4zc222"
    //mail id = test1@gmail.com  pass 123456
    // profile pic = "https://firebasestorage.googleapis.com/v0/b/places-df5ef.appspot.com/o/profile_pictures%2FnfDEw63SVUNzkdWF5ABjvUEGAc92?alt=media&token=ff435165-e909-48aa-bf3e-c5325a5facf1"
    return HomePage(uid:"s6BWxaZKIQNzcyxKA4I6Nr4zc222" );
    // return LoginPage();
    // return ChooseProfilePic(userModel: userModel);
    // return SplashScreen();

  }
}
