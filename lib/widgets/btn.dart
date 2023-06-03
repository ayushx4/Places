import 'package:flutter/material.dart';

class Btn extends StatefulWidget {

  String text;
  TextStyle? textStyle;
  Color? btnColor;
  Gradient? btnGradient;
  List<BoxShadow>? btnShadow;
  VoidCallback? onTap;
  double? btnHeight;
  double? btnWidth;


  Btn({
    required this.text,
    this.btnColor,
    this.onTap,
    this.btnHeight,
    this.btnWidth,
    this.btnGradient,
    this.btnShadow,
    this.textStyle,
  });

  @override
  State<Btn> createState() => _BtnState();
}

class _BtnState extends State<Btn> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        // height: 45,
        //   width: 120,
        height: widget.btnHeight ?? 45,
        width: widget.btnWidth ?? 120,
          duration:Duration(milliseconds: 1000),
        decoration: BoxDecoration(
          boxShadow: widget.btnShadow,
          color: widget.btnColor ?? Colors.blue,
          gradient: widget.btnGradient,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Center(
            child: Text(widget.text,
              textAlign: TextAlign.center,
              style: widget.textStyle,
            )
        ),
      ),
    );
  }
}

