import 'package:clg_mat/constants/const_colors.dart';
import 'package:clg_mat/widgets/place_feed_design.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ShowPlacesList extends StatefulWidget {
  //give user id to show user place list
  String uid;
  ShowPlacesList({
    required this.uid
});

  @override
  State<ShowPlacesList> createState() => _ShowPlacesListState();
}

class _ShowPlacesListState extends State<ShowPlacesList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String,dynamic>>>(
        stream: FirebaseFirestore.instance.collection("usersPlacesDetail").doc(widget.uid).snapshots(),
        builder:(context,snapshot){
          if(snapshot.hasData){
            List? placesList = snapshot.data!["placesList"];

            if(placesList!=null){
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                  itemCount: placesList.length,
                  itemBuilder:(context,index){
                    String placeId = placesList[index];
                    return PlaceFeedDesign(placeId: placeId);
                  }
              );
            }else{
              // return Text("Create any place you want");
              return
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(height:800,color: Colors.red,),
                      Container(height:800,color: Colors.black45,),
                      Container(height:800,color: Colors.red,),
                      Container(height:800,color: Colors.yellow,),
                      Container(height:800,color: Colors.red,),
                    ],

                  ),
                )
              ;
            }

          }
          else{
            return Center(
              child: Text("no place to show"),
            );
          }

        }
    );
  }
}
