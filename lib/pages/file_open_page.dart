import 'package:flutter/material.dart';

class FileOpenPage extends StatefulWidget {
  const FileOpenPage({super.key});

  @override
  State<FileOpenPage> createState() => _FileOpenPageState();
}

class _FileOpenPageState extends State<FileOpenPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
         child: Center(
           child: Text("File open page"),
         ),
        ),
      ),
    );
  }
}
