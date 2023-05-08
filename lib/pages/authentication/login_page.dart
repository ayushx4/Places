import 'package:clg_mat/widgets/btn.dart';
import 'package:clg_mat/widgets/input_field.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      backgroundColor: Colors.brown,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InputFeild(
                    controller:emailController ,
                    isPassword: false,
                    label:"Email",
                  hintText: "Enter email",
                ),

                InputFeild(
                    controller: passwordController,
                    isPassword: true,
                    label: "Password",
                  hintText: "Enter password",
                ),
                SizedBox(height: 18,),

                Btn(
                    text: "Login"
                ),


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

              const Text
                ("don't have account ?",
                style: TextStyle(color: Colors.white),
              ),

              const SizedBox(width: 5,),

              GestureDetector(
                  child: Text(
                    "Create new",
                    style: TextStyle(color: Colors.blue.shade300,fontSize: 16),
                  ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
