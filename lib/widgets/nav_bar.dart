import 'package:flutter/material.dart';

import '../pages/home/home_page.dart';

class NavBar extends StatefulWidget {
  final double? height;
  int? index;
  final double? pos;

  NavBar({
    this.height,
    this.index,
    this.pos,
});

  @override
  State<NavBar> createState() => _NavbarState();
}

class _NavbarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color:Color(0xFF4D4545),
      height: widget.height,
      width: MediaQuery.of(context).size.width,

      child: Stack(
        //icon row
        children: [

          Positioned(
            bottom: 10,
              width: MediaQuery.of(context).size.width,
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
//Home
                  IconBottomBar(
                    test: true,
                    icon: Icons.home_filled,
                    selected: widget.index == 0,
                    onPressed: (){
                      setState(() {
                        widget.index = 0;
                      });
                    },
                  ),

//Add
                  IconBottomBar(
                    test: true,
                    icon: Icons.add_circle,
                    selected:widget.index == 1,
                    onPressed: (){
                      setState(() {
                        widget.index = 1;
                      });
                    },
                  ),

//Profile
                  IconBottomBar(
                    test: true,
                    icon: Icons.person,
                    selected: widget.index == 2,
                    onPressed: (){
                      setState(() {
                        widget.index = 2;
                      });
                    },
                  ),

                ],
              )
          ),

          //selected icon background triangle,

        ],
      ),
    );
  }
}
