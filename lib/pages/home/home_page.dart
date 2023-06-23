import 'package:clg_mat/constants/const_colors.dart';
import 'package:clg_mat/pages/create_place_page.dart';
import 'package:clg_mat/pages/profile_page.dart';
import 'package:clg_mat/pages/show_places_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomePage extends StatefulWidget {
  String uid;
  HomePage({super.key, required this.uid});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // int _selected = 0;
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: ConstColor.SCWhite,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: ConstColor.SCWhite,
    ));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ConstColor.bgColor,
      body: SafeArea(
        child: Container(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(widget.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                String? profilePic = snapshot.data!["profilePic"];

                if (snapshot.hasData) {
                  return Column(
                    children: [
                      // account and search bar
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // account avatar
                            GestureDetector(
                              onTap: (){
                                Navigator.of(context).popUntil((route) => route.isFirst);
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage(uid: widget.uid)));
                              },
                              child: CircleAvatar(
                                backgroundImage: (profilePic == null)
                                    ? AssetImage("assets/images/user.png")
                                        as ImageProvider
                                    : NetworkImage(profilePic),
                              ),
                            ),

                            //search bar
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 5),
                                child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                      // border: Border.all(color: Colors.black),
                                      color: ConstColor.mainColorL2.withOpacity(0.4),
                                      // color: Colors.black12,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: TextField(
                                        cursorColor: ConstColor.mainColor,
                                        controller: searchController,
                                        autofocus: false,
                                        decoration: InputDecoration(
                                            hintText: "search",
                                            border: InputBorder.none,
                                            icon: Icon(MdiIcons.magnify,
                                              color: ConstColor.mainColor,
                                            )
                                        ),
                                      ),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Divider(
                        height: 0,
                      ),

                      // word and my place option
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                "World",
                                style: TextStyle(color: ConstColor.blackColor),
                              )),
                          TextButton(
                            onPressed: () {},
                            child: Text("Your place",
                                style: TextStyle(color: ConstColor.blackColor)),
                          ),
                        ],
                      ),

                      Divider(
                        height: 0,
                      ),

                      // Feed
                      Expanded(
                        child: ShowPlacesList(uid: widget.uid),
                      )
                    ],
                  );
                } else {
                  return Center(
                    child: Text("something went wrong try to relogin"),
                  );
                }
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ConstColor.mainColor,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CreatePlacePage(uid: widget.uid)));
        },
        child: Icon(MdiIcons.plus,
          color: Colors.white,
        ),
      ),
    );
  }
}
