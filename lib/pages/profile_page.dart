import 'package:clg_mat/constants/const_textstyle.dart';
import 'package:clg_mat/pages/show_places_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/const_colors.dart';
import '../constants/const_values.dart';



class ProfilePage extends StatefulWidget {
  String? uid;
  ProfilePage({required this.uid});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

   final int _placeAboutMaxLine = 6;



  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: ConstColor.SCWhite,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: ConstColor.SCWhite,
        ));



    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(widget.uid)
            .snapshots(),
        builder: (context, userDetailSnapshot) {

          String userName = userDetailSnapshot.data!["userName"];
          String aboutUser = userDetailSnapshot.data?["aboutUser"];
          String mailId = userDetailSnapshot.data!["mailId"];
          String? profilePic = userDetailSnapshot.data!["profilePic"];
          int? avatar = userDetailSnapshot.data!["avatar"];




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

          return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("usersPlacesDetail")
                  .doc(widget.uid)
                  .snapshots(),
              builder: (context , userPlaceDetailSnapshot){


                if (userDetailSnapshot.hasData) {
                  List? placeList = userPlaceDetailSnapshot.data!["placesList"];
                  int placesCount =placeList!.length;

                  return Scaffold(
                    appBar: AppBar(

//back button
                      leading: IconButton(
                        color: ConstColor.elementBlackColor,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.arrow_back),

                      ),

//user name
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              userName,
                              style: const TextStyle(
                              color: Colors.black,
                                fontSize:22,
                                fontWeight: FontWeight.bold,
                                fontFamily: ConstantTextStyle.alegreya_Sans
                          )),

                          Text("$placesCount Places",
                            style: const TextStyle(
                              fontSize: 12,
                                color: ConstColor.fontBlackk
                            ),),
                        ],
                      ),

//more option
                      actions: [
                        IconButton(
                            onPressed: (){},
                            icon: const Icon(Icons.more_vert,color: ConstColor.elementBlackColor,)
                        )
                      ],

                      elevation: 1,
                      backgroundColor: ConstColor.bgColor,

                    ),


                    body: SafeArea(
                      child: NotificationListener<OverscrollIndicatorNotification>(
                        onNotification: (OverscrollIndicatorNotification overscroll) {
                          overscroll.disallowGlow();
                          return true;
                        },
                        child: SingleChildScrollView(
                          physics:const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              
                              //user profile_pic and user_name 
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 80,
                                        backgroundImage: setProfilePic(),
                                      ),

                                      Text(
                                          userName,
                                          style: const TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w900,
                                              fontFamily: ConstantTextStyle.notoSansHK
                                          )
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                              
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  aboutUser,
                                  maxLines: _placeAboutMaxLine,
                                  style: const TextStyle(
                                    fontFamily: ConstantTextStyle.josefin_Sans,
                                    fontWeight: FontWeight.w400
                                ),
                                ),
                              ),

                              const Divider(),

                              //current user places_list
                              SizedBox(
                                height: MediaQuery.of(context).size.height,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Your places",style: TextStyle(fontWeight: FontWeight.bold),),

                                    Divider(),

                                    Expanded(child: ShowPlacesList(
                                      uid: widget.uid.toString(),
                                      forProfile:true,
                                    )),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }else if(userDetailSnapshot.hasError){
                  return const Center(
                    child: Text("something went wrong try to re-login"),
                  );
                } else {
                  return const Center(child: SizedBox(height: 30 ,child: CircularProgressIndicator()));
                }

              }
          );

        });
  }
}



