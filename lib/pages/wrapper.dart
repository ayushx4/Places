import 'package:clg_mat/models/user_model.dart';
import 'package:clg_mat/pages/authentication/profile/basic_detail.dart';
import 'package:clg_mat/pages/authentication/signup_page.dart';
import 'package:clg_mat/pages/home/home_page.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel userModel = UserModel(uid: "abc1234");
    return HomePage(uid: userModel.uid.toString());
  }
}
