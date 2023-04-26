import 'package:flutter/material.dart';

class InputFeild extends StatefulWidget {
  String? hintText;
  String label;
  TextEditingController controller;
  bool isPassword;


  InputFeild({
    required this.controller,
    required this.isPassword,
    required this.label,
    this.hintText,
});

  @override
  State<InputFeild> createState() => _InputFeildState();
}

class _InputFeildState extends State<InputFeild> {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: TextField(
        controller: widget.controller,
        obscureText: widget.isPassword,
        obscuringCharacter: "*",

        decoration: InputDecoration(
          hintText: widget.hintText,
          label: Text(widget.label),
        ),
      ),
    );
  }
}
