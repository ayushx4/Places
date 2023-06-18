import 'package:clg_mat/models/user_model.dart';
import 'package:clg_mat/pages/show_place.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel userModel = UserModel(uid: "abc1234");
    // return HomePage(uid: userModel.uid.toString());
    // return SignUpPage();
    return ShowPlace(uid: userModel.uid.toString(), placeId: "13e2cc1c-c1f9-4e51-81f2-c307a6562d73",isViwersPlace: true,);
  }
}
