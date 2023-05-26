import 'package:clg_mat/pages/tabs/tab_add_page.dart';
import 'package:clg_mat/pages/tabs/tab_home_page.dart';
import 'package:clg_mat/pages/tabs/tab_my_profile_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  String uid;
  HomePage({required this.uid});

  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {

  int _selected =0;
  final screen = [
    TabHomePage(),
    TabAddPage(),
    TabMyProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // body:screen[_selected],
      body: SafeArea(
        child: Stack(
          children: [

            screen[_selected],
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
                      height: 68,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0 , vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
//Home
                            IconBottomBar(
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

  IconBottomBar({
    required this.onPressed,
    required this.icon,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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




