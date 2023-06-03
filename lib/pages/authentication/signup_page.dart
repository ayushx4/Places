import 'package:clg_mat/services/auth_services.dart';
import 'package:clg_mat/widgets/btn.dart';
import 'package:clg_mat/widgets/custom_input_field.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomInputFeild(
                  controller:emailController ,
                  isPassword: false,
                  label:"Email",
                  hintText: "Enter email",
                ),

                CustomInputFeild(
                  controller: passwordController,
                  isPassword: true,
                  label: "Password",
                  hintText: "Enter password",
                ),
                CustomInputFeild(
                  controller: confirmPasswordController,
                  isPassword: true,
                  label: "Confirm password",
                  hintText: "Enter password",
                ),
                SizedBox(height: 18,),

                Btn(
                  onTap: ()async{

                    AuthServices().signInWithMail(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                      context
                    );
                  },
                    text: "Sign Up",
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}


