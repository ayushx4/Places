import 'dart:ui';

import 'package:clg_mat/pages/tabs/tab_add_page.dart';
import 'package:clg_mat/pages/tabs/tab_home_page.dart';
import 'package:clg_mat/pages/tabs/tab_my_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {

  String uid;
  HomePage({super.key, required this.uid});

  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {

  int _selected =0;


  @override
  Widget build(BuildContext context) {

    final screen = [
      TabHomePage(),
      TabAddPage(uid: widget.uid,),
      TabMyProfilePage(),
    ];

    return Scaffold(

      // body:screen[_selected],
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [

            Expanded(
                child: screen[_selected]
            ),
            Positioned(
              bottom: 0,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40,vertical: 5),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xff4d4545),
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  child: BottomAppBar(
                    elevation: 0,
                    color: Colors.transparent,

                    child: SizedBox(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0 , vertical: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
//Home
                            IconBottomBar(
                              test: false,
                              icon: Icons.home_filled,
                              selected: _selected == 0,
                              onPressed: (){
                                setState(() {
                                  _selected = 0;
                                });
                              },
                            ),

//Add
                            IconBottomBar(
                              test: false,
                              icon: Icons.add_circle,
                              selected:_selected == 1,
                              onPressed: (){
                                setState(() {
                                  _selected = 1;
                                });
                              },
                            ),

//Profile
                            IconBottomBar(
                              test: false,
                              icon: Icons.person,
                              selected: _selected == 2,
                              onPressed: (){
                                setState(() {
                                  _selected = 2;
                                });
                              },
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),

    );
  }

}

class IconBottomBar extends StatelessWidget {
  final IconData icon;
  final bool selected;
  final VoidCallback onPressed;
  final bool test;

  IconBottomBar({
    required this.onPressed,
    required this.icon,
    required this.selected,
    required this.test,
  });

  @override
  Widget build(BuildContext context) {
    return (test) ?
    Positioned(
      // width: MediaQuery.of(context).size.width,
      bottom: 1,
      child: Container(
        height: 130,
        width: 100,
        color: Colors.yellowAccent,
        child: Stack(
          children: [

            // selected icon background triangle
            (selected) ? Positioned(
                bottom: 30,
                left: 10,
                right: 10,
                child:ClipPath(
                  child: Container(
                    height: 70,
                    color: Colors.brown,
                  ),
                  clipper: _Triangle(),
                )
            )
                :
            Container(color: Colors.transparent,),

            // icon
            Positioned(
              bottom: (selected) ?  30 : 10,
              left: 10,
              right: 10,
              child: IconButton(
                onPressed: onPressed,
                icon: Icon(
                  icon,
                  size: 35,
                  // color: selected ? Colors.red : Colors.white,
                  color: (selected) ? Color(0xFFFF4409) : Colors.white,
                ),
              ),
            ),

          ],
        ),
      ),
    )

    :

    Column(
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            icon,
            size: 35,
            // color: selected ? Colors.red : Colors.white,
            color: selected ? const Color(0xFFFF4409) : Colors.white,
          ),
        ),

      ],
    );

  }
}


class _Triangle extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    final path =Path();
    path.lineTo(size.width-20, 0);
    path.quadraticBezierTo(size.width, 0, size.width, 20);
    path.lineTo(size.width/2+10, size.height-10);
    path.quadraticBezierTo(size.width/2, size.height, size.width/2-10, size.height-10);
    path.lineTo(0, 20);
    path.quadraticBezierTo(0, 0, size.width-20, 0);
    path.lineTo(size.width-20, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
  }








