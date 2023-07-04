import 'dart:async';

import 'package:clg_mat/constants/const_colors.dart';
import 'package:clg_mat/constants/const_values.dart';
import 'package:clg_mat/pages/authentication/signup_page.dart';
import 'package:clg_mat/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1) ,(){
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context)=>const SignUpPage())
      );
    });
  }

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
      backgroundColor: ConstColor.mainColorL2,
      body: SafeArea(
        child: Center(
          child: SizedBox(
            height: 100,
              child: Image.asset(ConstValues.logoFilePath),
          ),
        ),
      ),
    );
  }
}
