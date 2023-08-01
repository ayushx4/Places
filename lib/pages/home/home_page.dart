import 'package:clg_mat/constants/const_colors.dart';
import 'package:clg_mat/constants/const_values.dart';
import 'package:clg_mat/pages/create_place_page.dart';
import 'package:clg_mat/pages/profile_page.dart';
import 'package:clg_mat/pages/show_places_list.dart';
import 'package:clg_mat/widgets/alert_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
  late ScrollController _scrollControllerOne ,_scrollControllerTwo;

  @override
  void initState() {
    super.initState();
    _scrollControllerOne = ScrollController();
    _scrollControllerTwo = ScrollController();
  }


  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
    _scrollControllerOne.dispose();
    _scrollControllerTwo.dispose();
  }

  @override
  Widget build(BuildContext context) {


    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: ConstColor.SCWhite,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: ConstColor.SCWhite,
        ));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ConstColor.bgColor,
      body: SafeArea(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("users")
                .doc(widget.uid)
                .snapshots(),
            builder: (context, snapshot) {

              if(snapshot.connectionState==ConnectionState.active){
                if (snapshot.hasData) {

                  String? profilePic = snapshot.data!["profilePic"];
                  int? avatar = snapshot.data!["avatar"];

                  ImageProvider setProfilePic(){

                    if(avatar==1){
                      return const AssetImage(ConstValues.defaultMaleAvatar);
                    }else if(avatar==2){
                      return const AssetImage(ConstValues.defaultFemaleAvatar);
                    } else if(profilePic!=null){
                      return NetworkImage(profilePic);
                    }else{
                      return const AssetImage("assets/images/user.png");
                    }

                  }

                  return NestedScrollView(

                    floatHeaderSlivers: true,

                    headerSliverBuilder: (context,innerBoxIsScrolled)=> [
                      SliverAppBar(
                        backgroundColor: ConstColor.bgColor,
                        // floating: true,
                        // pinned: false,
                        // expandedHeight:69,



                        flexibleSpace: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [

                                  //profile pic
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.of(context).popUntil((route) => route.isFirst);
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage(uid: widget.uid)));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 5),
                                      child: CircleAvatar(
                                        backgroundImage: setProfilePic(),
                                        radius: 16,
                                      ),
                                    ),
                                  ),

                                  //search bar
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 0),
                                      child: Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            const BorderRadius.all(Radius.circular(15)),
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
                                              onTapOutside: (event)=> FocusManager.instance.primaryFocus?.unfocus(),
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
                                  )

                                ],
                              ),
                            ),
                          ],
                        ),
                      )
              ],
                    body: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(onPressed: (){},
                                child:const Text("World")
                            ),
                            TextButton(onPressed: (){},
                                child:const Text("Your place")
                            )
                          ],
                        ),

                        Flexible(
                            child: ShowPlacesList(uid: widget.uid, forProfile: true)
                        )
                      ],
                    ),

                  );
                } else if(snapshot.hasError) {
                  return AlertMessage(context, Text(snapshot.error.toString()));
                } else{
                  return const Center(child:Text('Something want wrong!'),);
                }

              }else{
                return const Center(child: SizedBox(height: 30,width:30,child: CircularProgressIndicator()));
              }


            }),
      ),
      floatingActionButton: FloatingActionButton(
          elevation: 5,
          // backgroundColor: Colors.transparent,
          backgroundColor: ConstColor.mainColor,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CreatePlacePage(uid: widget.uid)));
          }, child: Icon(MdiIcons.plus,color: Colors.white,size: 30,)      ),
    );
  }





}






//
// Column(
// children: [
//
// Padding(
// padding: const EdgeInsets.all(8.0),
// child: Row(
// // mainAxisAlignment: MainAxisAlignment.start,
// children: [
// // account avatar
// GestureDetector(
// onTap: (){
// Navigator.of(context).popUntil((route) => route.isFirst);
// Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage(uid: widget.uid)));
// },
// child: CircleAvatar(
// backgroundImage: setProfilePic(),
// ),
// ),
//
// //search bar
// Expanded(
// child: Padding(
// padding: const EdgeInsets.symmetric(
// horizontal: 8, vertical: 5),
// child: Container(
// height: 50,
// decoration: BoxDecoration(
// borderRadius:
// BorderRadius.all(Radius.circular(15)),
// // border: Border.all(color: Colors.black),
// color: ConstColor.mainColorL2.withOpacity(0.4),
// // color: Colors.black12,
// ),
// child: Padding(
// padding: const EdgeInsets.symmetric(
// horizontal: 10),
// child: TextField(
// cursorColor: ConstColor.mainColor,
// controller: searchController,
// autofocus: false,
// decoration: InputDecoration(
// hintText: "search",
// border: InputBorder.none,
// icon: Icon(MdiIcons.magnify,
// color: ConstColor.mainColor,
// )
// ),
// ),
// )),
// ),
// ),
// ],
// ),
// ),
//
// const Divider(
// height: 0,
// ),
//
// // word and my place option
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceAround,
// children: [
// TextButton(
// onPressed: () {},
// child: const Text(
// "World",
// style: TextStyle(color: ConstColor.elementBlackColor),
// )),
// TextButton(
// onPressed: () {},
// child: const Text("Your place",
// style: TextStyle(color: ConstColor.elementBlackColor)),
// ),
// ],
// ),
//
// const Divider(
// height: 0,
// ),
//
// // Feed
// Expanded(
// child: ShowPlacesList(uid: widget.uid),
// )
// ],
// )




///// return to has data
//
// return
// CustomScrollView(
// slivers: <Widget>[
// SliverAppBar(
// backgroundColor: ConstColor.bgColor,
// floating: true,
// // expandedHeight:69,
//
//
//
// flexibleSpace: Column(
// children: [
// Padding(
// padding: const EdgeInsets.symmetric(horizontal: 5),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceAround,
// children: [
//
// //profile pic
// GestureDetector(
// onTap: (){
// Navigator.of(context).popUntil((route) => route.isFirst);
// Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage(uid: widget.uid)));
// },
// child: Padding(
// padding: const EdgeInsets.symmetric(horizontal: 5),
// child: CircleAvatar(
// backgroundImage: setProfilePic(),
// radius: 16,
// ),
// ),
// ),
//
// //search bar
// Expanded(
// child: Padding(
// padding: const EdgeInsets.symmetric(
// horizontal: 5, vertical: 0),
// child: Container(
// height: 50,
// decoration: BoxDecoration(
// borderRadius:
// const BorderRadius.all(Radius.circular(15)),
// // border: Border.all(color: Colors.black),
// color: ConstColor.mainColorL2.withOpacity(0.4),
// // color: Colors.black12,
// ),
// child: Padding(
// padding: const EdgeInsets.symmetric(
// horizontal: 10),
// child: TextField(
// cursorColor: ConstColor.mainColor,
// controller: searchController,
// autofocus: false,
// onTapOutside: (event)=> FocusManager.instance.primaryFocus?.unfocus(),
// decoration: InputDecoration(
// hintText: "search",
// border: InputBorder.none,
// icon: Icon(MdiIcons.magnify,
// color: ConstColor.mainColor,
// )
// ),
// ),
// )),
// ),
// )
//
// ],
// ),
// ),
// ],
// ),
// ),
//
//
// SliverToBoxAdapter(
// child: SizedBox(
// height: MediaQuery.of(context).size.height,
// child: Column(
// children: [
//
// const Divider(
// height: 0,
// ),
//
// // Feed
// Expanded(
// child: ShowPlacesList(uid: widget.uid, forProfile: false),
// )
// ],
// ),
// ),
// )
// ],
// );
