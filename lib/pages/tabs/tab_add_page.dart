import 'package:clg_mat/pages/tabs/place/new_place_page.dart';
import 'package:clg_mat/widgets/btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class TabAddPage extends StatefulWidget {

  String? uid;

  TabAddPage({
    required this.uid,
});

  @override
  State<TabAddPage> createState() => _TabAddPageState();
}

class _TabAddPageState extends State<TabAddPage> {

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: Color(0xFF413636),
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      )
    );

    double _bgRadius = 100;


    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: Stack(
        children: [

          //background
          Positioned(
              bottom: 0,
              child:ClipPath(
                clipper: AddBgClipper(),
                child: Container(
                  height: MediaQuery.of(context).size.height/2.8,
                  width: MediaQuery.of(context).size.width,
                  color: Color(0xFF413636),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Btn(
                          text:"Select \nplace",
                          textStyle: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                          ),
                          btnHeight: 70,
                          btnWidth: 110,
                          btnGradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color(0xFF848484),
                              Color(0xFF525252),
                            ],
                          ),
                          btnShadow: [
                            BoxShadow(
                                color: Colors.black54,
                                offset: const Offset(1.0 , 1.0),
                                blurRadius: 4,
                            )
                          ],
                        ),

                        SizedBox(
                          width: 30,
                        ),

                        Btn(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewPlacePage(uid: widget.uid,)
                              )
                            );
                          },
                          text: "New \nplace",
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          ),
                          btnHeight: 70,
                          btnWidth: 110,
                          btnGradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xFFFD9393),
                                Color(0xFFFF4206),
                              ]
                          ),
                            btnShadow: [
                              BoxShadow(
                                color: Colors.black54,
                                offset: const Offset(1.0 , 1.0),
                                blurRadius: 4,
                              ),
                            ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
          ),

          //buttons


        ],
      )
    );
  }

  //
  // DropdownMenuItem<String> buildMenuButton (String item){
  //   return DropdownMenuItem(
  //     value: item,
  //     child:Text(item),
  //   );
  }

class AddBgClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0,80);
    path.quadraticBezierTo(size.width/2, 0, size.width, 80);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    // path.lineTo(0, size.height-40);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;

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
