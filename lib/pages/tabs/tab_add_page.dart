import 'package:clg_mat/widgets/input_field.dart';
import 'package:flutter/material.dart';


class TabAddPage extends StatefulWidget {
  const TabAddPage({Key? key}) : super(key: key);

  @override
  State<TabAddPage> createState() => _TabAddPageState();
}

class _TabAddPageState extends State<TabAddPage> {

  var _fileTitle = TextEditingController();
  var _fileDis = TextEditingController();

  final fileTypeItems = ['Pdf','Link','Document'];
  String? fileTypeValue;

  @override
  Widget build(BuildContext context) {
    // return SafeArea(
    //   child: ,
    // );
    return Center(
      child: Text("add page"),
    );
  }


  DropdownMenuItem<String> buildMenuButton (String item){
    return DropdownMenuItem(
      value: item,
      child:Text(item),
    );
  }




}




//////////////////////////
// Center(
// child: Column(
// children: [
// // File Title
// InputFeild(
// controller: _fileTitle,
// isPassword: false,
// label: "File Name",
// ),
//
// //File dec
// InputFeild(
// controller: _fileDis,
// isPassword: false,
// label: "File Description"
// ),
//
// // Subject
// InputFeild(
// controller: _fileDis,
// isPassword: false,
// label: "File Description"
// ),
//
// //File type
// Padding(
// padding: const EdgeInsets.all(8.0),
// child: Container(
// decoration: BoxDecoration(
// borderRadius: BorderRadius.all(Radius.circular(8)),
// color:Colors.white70
// ),
// child: Padding(
// padding: const EdgeInsets.symmetric(horizontal: 10),
// child: DropdownButtonHideUnderline(
// child: DropdownButton(
// hint: Text("File Type"),
// disabledHint: Text("File Type"),
// value: fileTypeValue,
// isExpanded: true,
// items: fileTypeItems.map(buildMenuButton).toList(),
// onChanged:(value){
// setState(() {
// this.fileTypeValue = value ;
// });
// }
// ),
// ),
// ),
// ),
// ),
//
//
//
// ],
// )
// )
