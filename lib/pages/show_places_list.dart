import 'package:clg_mat/widgets/place_feed_design.dart';
import 'package:clg_mat/widgets/profile_placelist_design.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/alert_message.dart';

class ShowPlacesList extends StatefulWidget {
  //give user id to show user place list
  String uid;
  bool forProfile;
  bool? scroll;

  ShowPlacesList({
    super.key,
    required this.uid,
    required this.forProfile,
    this.scroll,
  });



  @override
  State<ShowPlacesList> createState() => _ShowPlacesListState();
}

class _ShowPlacesListState extends State<ShowPlacesList> {
  @override
  Widget build(BuildContext context) {

    bool scroll = widget.scroll ?? true;

    return StreamBuilder<DocumentSnapshot<Map<String,dynamic>>>(
        stream: FirebaseFirestore.instance.collection("usersPlacesDetail").doc(widget.uid).snapshots(),
        builder:(context,snapshot){
          if(snapshot.connectionState==ConnectionState.active){
            if(snapshot.hasData){
              List? placesList = snapshot.data!["placesList"];

              if(placesList!=null){
                return ListView.builder(
                  shrinkWrap: true,
                  physics: (scroll) ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
                    itemCount: placesList.length,
                    itemBuilder:(context,index){
                      String placeId = placesList[index];
                      return (widget.forProfile) ? ProfilePlacelistDesign(placeId: placeId,uid: widget.uid) : PlaceFeedDesign(placeId: placeId,uid: widget.uid,);
                    }
                );
              }else{
                return const Text("Create any place you want");
                // return
                //   Column(
                //     children: [
                //       Container(height:800,color: Colors.red,),
                //       Container(height:800,color: Colors.black45,),
                //       Container(height:800,color: Colors.red,),
                //       Container(height:800,color: Colors.yellow,),
                //       Container(height:800,color: Colors.red,),
                //     ],
                //
                // );
              }

            }else if(snapshot.hasError){
              return AlertMessage(context,Text(snapshot.error.toString()));
            }else{
              return const Center(child: Text('Something want wrong'),);
            }
          }else{
            return const Center(child: SizedBox(height: 15 ,child: CircularProgressIndicator()),);
          }

        }
    );
  }
}
