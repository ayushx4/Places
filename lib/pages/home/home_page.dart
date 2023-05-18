import 'package:clg_mat/pages/tabs/tab_add_file_page.dart';
import 'package:clg_mat/pages/tabs/tab_home_page.dart';
import 'package:clg_mat/pages/tabs/tab_my_library_page.dart';
import 'package:clg_mat/pages/tabs/tab_my_profile_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  String uid;
  HomePage({required this.uid});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _currentIndex = 0;

  List<BottomNavigationBarItem> itemList =[
    BottomNavigationBarItem(
      icon: Icon(Icons.home_filled),
      label: "Home",
    ),

    BottomNavigationBarItem(icon: Icon(Icons.add),label: "Add"),

    BottomNavigationBarItem(icon: Icon(Icons.collections_outlined),label: "My Library"),

    BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined),label: "My profile"),
  ];

  final tab = [
    TabHomePage(),
    TabAddFilePage(),
    TabMYLibraryPage(),
    TabMyProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fucking clg mate"),
      ),
      // backgroundColor:
      body: tab[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        items: itemList,
        onTap: (index){
          setState(() {
            _currentIndex=index;
          });
        },
      ),


    );


  }
}
