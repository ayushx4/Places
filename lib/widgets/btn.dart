import 'package:flutter/material.dart';

class Btn extends StatefulWidget {

  String text;
  Color? textColor;
  Color? btnColor;
  VoidCallback? onTap;

  Btn({required this.text, this.btnColor,this.onTap,this.textColor});

  @override
  State<Btn> createState() => _BtnState();
}

class _BtnState extends State<Btn> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        height: 45,
          width: 120,
          duration:Duration(milliseconds: 1000),
        decoration: BoxDecoration(
          color: widget.btnColor ?? Colors.blue,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
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

