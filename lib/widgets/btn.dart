import 'package:flutter/material.dart';

class Btn extends StatefulWidget {

  String text;
  Color? textColor;
  Color? btnColor;

  Btn({required this.text, this.btnColor});

  @override
  State<Btn> createState() => _BtnState();
}

class _BtnState extends State<Btn> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: AnimatedContainer(
        height: 45,
          width: 120,
          duration:Duration(milliseconds: 1000),
        decoration: BoxDecoration(
          color: widget.btnColor ?? Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(5))
        ),
        child: Center(
            child: Text(widget.text,
              style: TextStyle(color: widget.textColor ?? Colors.white),
            )
        ),
      ),
    );
  }
}

