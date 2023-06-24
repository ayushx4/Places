import 'dart:developer';

import 'package:clg_mat/pages/authentication/signup_page.dart';
import 'package:clg_mat/services/auth_services.dart';
import 'package:clg_mat/widgets/btn.dart';
import 'package:clg_mat/widgets/custom_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/const_colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

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
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 70,
                  child: const Image(
                      image: AssetImage("assets/images/app_logo3.png")),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: const Text(
                      "Log In",
                      style: TextStyle(
                        color: ConstColor.mainColorD2,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Alegreya_Sans",
                        // fontSize: double.infinity
                      ),
                    ),
                  ),
                ),
                const Text("stay login",
                    style: TextStyle(
                      color: ConstColor.mainColorD1,
                      fontWeight: FontWeight.w300,
                      fontFamily: "Josefin_Sans",
                      fontSize: 18,
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: CustomInputFeild(
                    controller: emailController,
                    isPassword: false,
                    label: "Email",
                    hintText: "Enter email",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: CustomInputFeild(
                    controller: passwordController,
                    isPassword: true,
                    label: "Password",
                    hintText: "Enter password",
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                Btn(
                    onTap: () {
                      AuthServices().LogInWithMail(emailController.text.trim(),
                          passwordController.text.trim(), context);
                    },
                    text: "Login",
                    textStyle: TextStyle(color: Colors.white),
                    btnColor: ConstColor.mainColor,
                    btnWidth: MediaQuery.of(context).size.width,
                    btnShadow: [
                      BoxShadow(
                        color: ConstColor.mainColorL1,
                        offset: Offset(5, 5),
                      )
                    ]),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "why you don't have an account ?",
                style: TextStyle(color: ConstColor.mainColorD1),
              ),
              const SizedBox(
                width: 5,

              ),
              GestureDetector(
                onTap: (){
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context)=> SignUpPage(),
                  ));
                },
                child: Text(
                  "Create new",
                  style: TextStyle(color: Colors.black,fontWeight : FontWeight.w600,fontFamily:"Alegreya_Sans",fontSize: 18)
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
