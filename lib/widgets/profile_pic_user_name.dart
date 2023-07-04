import 'package:clg_mat/constants/const_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProfilePicUserName extends StatefulWidget {

  String? uid;
  ProfilePicUserName({
    required this.uid
});

  @override
  State<ProfilePicUserName> createState() => _ProfilePicUserNameState();
}

class _ProfilePicUserNameState extends State<ProfilePicUserName> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String,dynamic>>>(
      stream: FirebaseFirestore.instance.collection("users").doc(widget.uid).snapshots(),
        builder:(context,snapshot){
      if(snapshot.hasData){
        String url = snapshot.data!["profilePic"];
        String userName =snapshot.data!["userName"];
        return Container(
          color: ConstColor.bgColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundColor: ConstColor.widgetsBgGrayColor,
                backgroundImage: NetworkImage(url),
              ),

              const SizedBox(width: 5,),
              Expanded(
                  child: Text(userName,
                      style: const TextStyle(
                          overflow: TextOverflow.ellipsis)))

            ],
          ),
        );
      }else {
        return const CircularProgressIndicator();
      }
    }

    );
  }
}
