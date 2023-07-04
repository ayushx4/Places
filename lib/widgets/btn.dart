import 'dart:async';

import 'package:flutter/material.dart';

import '../constants/const_colors.dart';

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
        height: widget.btnHeight ?? 45,
        width: widget.btnWidth ?? MediaQuery.of(context).size.width/2,
          duration:const Duration(milliseconds: 10),
        decoration: BoxDecoration(
          boxShadow : widget.btnShadow ??  [
             BoxShadow(
            color: ConstColor.mainColorL1,
            offset: Offset(5, 5),
          )
          ],
          color: widget.btnColor ?? ConstColor.mainColor,
          gradient: widget.btnGradient,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Center(
            child: Text(widget.text,
              textAlign: TextAlign.center,
              style: widget.textStyle ?? const TextStyle(color: Colors.white),
            )
        ),
      ),
    );
  }
}

