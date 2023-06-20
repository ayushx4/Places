import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/const_colors.dart';



class ProfilePage extends StatefulWidget {
  String? uid;
  ProfilePage({required this.uid});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    
    
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
            systemNavigationBarColor: Color(0xFF4D4545),
            statusBarColor: ConstColor.SCWhite,
            statusBarIconBrightness: Brightness.dark
        )
    );

    return Center(
      child: StreamBuilder<DocumentSnapshot<Map<String,dynamic>>>(
        stream: FirebaseFirestore.instance.collection("users").doc(widget.uid).snapshots(),
        builder: (context, snapshot) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("My Profile page"),

              //Profile pic
              (snapshot.data!["profilePic"]==null) ?
              CircleAvatar(
                backgroundColor: Colors.black54,
                backgroundImage: AssetImage("assets/images/user.png"),
                radius: 70,
              )
              :
              CircleAvatar(
                backgroundColor: Colors.black54,
                backgroundImage: NetworkImage(snapshot.data!["profilePic"]),
                radius: 70,
              ),




            ],
          );
        }
      ),
    );;
  }
}
