import 'package:flutter/material.dart';

class Experimentpage extends StatefulWidget {
  const Experimentpage({Key? key}) : super(key: key);

  @override
  State<Experimentpage> createState() => _ExperimentpageState();
}

class _ExperimentpageState extends State<Experimentpage> {

var i=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child:Column(
            children: [
              Text("Click me"),
              Text(i.toString()),
              ElevatedButton(onPressed: (){
                setState(() {
                  i+=1;
                });
              }, child: Text("click"))
            ],
          ),
        ),
      ),
    );
  }
}











// Padding(
// padding: EdgeInsets.symmetric(horizontal: 40,vertical: 5),
// child: Container(
// decoration: BoxDecoration(
// color: Color(0xff4d4545),
// borderRadius: BorderRadius.all(Radius.circular(50)),
// ),
// child: BottomAppBar(
// elevation: 0,
// color: Colors.transparent,
//
// child: SizedBox(
// height: 68,
// width: MediaQuery.of(context).size.width,
// child: Padding(
// padding: EdgeInsets.symmetric(horizontal: 0 , vertical: 10),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// children: [
// //Home
// IconBottomBar(
// icon: Icons.home_filled,
// selected: _selected == 0,
// onPressed: (){
// setState(() {
// _selected = 0;
// });
// },
// ),
//
// //Add
// IconBottomBar(
//
// icon: Icons.add_circle,
// selected:_selected == 1,
// onPressed: (){
// setState(() {
// _selected = 1;
// });
// },
// ),
//
// //Profile
// IconBottomBar(
// icon: Icons.person,
// selected: _selected == 2,
// onPressed: (){
// setState(() {
// _selected = 2;
// });
// },
// ),
//
// ],
// ),
// ),
// ),
// ),
// ),
// )