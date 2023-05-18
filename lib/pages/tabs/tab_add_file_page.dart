import 'package:clg_mat/widgets/input_field.dart';
import 'package:flutter/material.dart';


class TabAddFilePage extends StatefulWidget {
  const TabAddFilePage({Key? key}) : super(key: key);

  @override
  State<TabAddFilePage> createState() => _TabAddFilePageState();
}

class _TabAddFilePageState extends State<TabAddFilePage> {

  var _fileTitle = TextEditingController();
  var _fileDis = TextEditingController();

  final fileTypeItems = ['Pdf','Link','Document'];
  String? fileTypeValue;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          children: [
            // File Title
            InputFeild(
              controller: _fileTitle,
              isPassword: false,
              label: "File Name",
            ),

            //File dec
            InputFeild(
                controller: _fileDis,
                isPassword: false,
                label: "File Description"
            ),

            // Subject
            InputFeild(
                controller: _fileDis,
                isPassword: false,
                label: "File Description"
            ),

            //File type
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color:Colors.white70
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  hint: Text("File Type"),
                    disabledHint: Text("File Type"),
                    value: fileTypeValue,
                    isExpanded: true,
                    items: fileTypeItems.map(buildMenuButton).toList(),
                    onChanged:(value){
                      setState(() {
                        this.fileTypeValue = value ;
                      });
                    }
                ),
              ),
            ),
          ),
        ),


            // subject

          ],
        )
    );
  }


  DropdownMenuItem<String> buildMenuButton (String item){
    return DropdownMenuItem(
      value: item,
      child:Text(item),
    );
  }




}
