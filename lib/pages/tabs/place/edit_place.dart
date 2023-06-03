import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditPlace extends StatefulWidget {

  String uid;
  String placeId;

  EditPlace({
    required this.uid,
    required this.placeId,
});

  @override
  State<EditPlace> createState() => _EditPlaceState();
}

class _EditPlaceState extends State<EditPlace> {
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xFF413636),
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.light,
    ));

    return Scaffold(
      body: SafeArea(
        child: Container(

        ),
      ),
    );
  }
}
