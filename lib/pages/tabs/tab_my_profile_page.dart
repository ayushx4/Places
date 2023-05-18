import 'package:flutter/material.dart';

class TabMyProfilePage extends StatefulWidget {
  const TabMyProfilePage({Key? key}) : super(key: key);

  @override
  State<TabMyProfilePage> createState() => _TabMyProfilePageState();
}

class _TabMyProfilePageState extends State<TabMyProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("My Profile page"),
    );;
  }
}
