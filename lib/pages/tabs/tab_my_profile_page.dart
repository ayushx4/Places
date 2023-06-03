import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TabMyProfilePage extends StatefulWidget {
  const TabMyProfilePage({Key? key}) : super(key: key);

  @override
  State<TabMyProfilePage> createState() => _TabMyProfilePageState();
}

class _TabMyProfilePageState extends State<TabMyProfilePage> {

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
            systemNavigationBarColor: Color(0xFF4D4545),
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark
        )
    );

    return Center(
      child: Text("My Profile page"),
    );;
  }
}
