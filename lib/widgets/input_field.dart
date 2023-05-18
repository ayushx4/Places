import 'package:flutter/material.dart';

class InputFeild extends StatefulWidget {
  Color? color;
  String? hintText;
  String label;
  TextEditingController controller;
  bool isPassword;



  InputFeild({
    required this.controller,
    required this.isPassword,
    required this.label,
    this.color,
    this.hintText,
});

  @override
  State<InputFeild> createState() => _InputFeildState();
}

class _InputFeildState extends State<InputFeild> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: widget.color ?? Colors.white70
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
                controller: widget.controller,
                obscureText: widget.isPassword,
                obscuringCharacter: "*",

                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: widget.hintText,
                  label: Text(widget.label),
                ),
              ),
        ),
      ),
    );
  }
}
