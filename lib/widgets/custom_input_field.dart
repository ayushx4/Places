import 'package:clg_mat/constants/const_colors.dart';
import 'package:flutter/material.dart';

class CustomInputFeild extends StatefulWidget {
  double? height;
  double? width;
  int? maxLine;
  Color? color;
  String? hintText;
  String label;
  TextEditingController controller;
  BoxDecoration? boxDecoration;
  bool isPassword;



  CustomInputFeild({
    required this.controller,
    required this.isPassword,
    required this.label,
    this.color,
    this.hintText,
    this.width,
    this.height,
    this.maxLine,
    this.boxDecoration
});

  @override
  State<CustomInputFeild> createState() => _CustomInputFeildState();
}

class _CustomInputFeildState extends State<CustomInputFeild> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height ?? null,
      width: widget.width ?? null,
      decoration: widget.boxDecoration ?? BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: widget.color ?? Colors.white70,
        border: Border.all(color: ConstColor.mainColorD2)
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextField(
          controller: widget.controller,
          onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
          obscureText: widget.isPassword,
          obscuringCharacter: "*",
          maxLines: widget.maxLine ?? 1,
          keyboardType: (widget.maxLine) != null ? TextInputType.multiline : null,

          decoration: InputDecoration(
            border: InputBorder.none ,
            hintText: widget.hintText,
            label: Text(widget.label,style: TextStyle(color: Colors.black54,fontSize: 16),),
          ),
        ),
      ),
    );
  }
}
