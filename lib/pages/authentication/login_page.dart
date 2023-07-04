import 'package:clg_mat/constants/const_textstyle.dart';
import 'package:clg_mat/constants/const_values.dart';
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
                const SizedBox(
                  height: 70,
                  child: Image(
                      image: AssetImage(ConstValues.logoFilePath)),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: const FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      "Log In",
                      style: TextStyle(
                        color: ConstColor.mainColorD2,
                        fontWeight: FontWeight.bold,
                        fontFamily: ConstantTextStyle.alegreya_Sans,
                        // fontSize: double.infinity
                      ),
                    ),
                  ),
                ),
                const Text("stay logged in",
                    style: TextStyle(
                      color: ConstColor.mainColorD1,
                      fontWeight: FontWeight.w300,
                      fontFamily: ConstantTextStyle.josefin_Sans,
                      fontSize: 18,
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: CustomInputFeild(
                    controller: emailController,
                    isPassword: false,
                    label: "Email",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: CustomInputFeild(
                    controller: passwordController,
                    isPassword: true,
                    label: "Password",
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                Btn(
                    onTap: () {
                      AuthServices().LogInWithMail(emailController.text.trim(),
                          passwordController.text.trim(), context);
                    },
                    text: "Login",
                    textStyle: const TextStyle(color: Colors.white),
                    btnColor: ConstColor.mainColor,
                    btnWidth: MediaQuery.of(context).size.width,
                    btnShadow: const [
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
      bottomNavigationBar: Padding(
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
                  MaterialPageRoute(builder: (context)=> const SignUpPage(),
                ));
              },
              child: const Text(
                "Create new",
                style: TextStyle(color: Colors.black,fontWeight : FontWeight.w600,fontFamily:"Alegreya_Sans",fontSize: 18)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
