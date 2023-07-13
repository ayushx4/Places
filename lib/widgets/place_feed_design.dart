import 'package:clg_mat/constants/const_colors.dart';
import 'package:clg_mat/pages/show_place.dart';
import 'package:clg_mat/widgets/alert_message.dart';
import 'package:clg_mat/widgets/profile_pic_user_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'date_time_formte.dart';

class PlaceFeedDesign extends StatefulWidget {
  final String? placeId;
  final String? uid;

  const PlaceFeedDesign({
    super.key,
    required this.placeId,
    required this.uid
  });

  @override
  State<PlaceFeedDesign> createState() => _PlaceFeedDesignState();
}

class _PlaceFeedDesignState extends State<PlaceFeedDesign> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection("places")
            .doc(widget.placeId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            String uid = snapshot.data!["uid"];
            String placeName = snapshot.data!["placeName"];
            String placeAbout = snapshot.data!["placeDescription"];
            String visibility = snapshot.data!["placeVisibility"];
            List? placeLikeList = snapshot.data!["likesUidList"];
            int placeLike = (placeLikeList==null) ? 0 : placeLikeList.length;
            Timestamp placeCreatedOn = snapshot.data!["placeCreatedOn"];

            return Column(
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    minWidth: 100,
                    // maxHeight: 600,
                  ),
                  child: Container(
                    decoration: const BoxDecoration(color: ConstColor.bgColor),
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      child: Column(
                        children: [
                          //profile pic and user name
                          SizedBox(
                            height: 40,
                              child: ProfilePicUserName(uid: uid)
                          ),

                          const Divider(),

                          // Text part Place name and place description
                          GestureDetector(
                            onTap: (){
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context)=>ShowPlace(
                                    uid: widget.uid.toString(),
                                    placeId:widget.placeId!,
                                ))
                              );

                            },
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical:0),
                                  child: Text(
                                    placeName,
                                    style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.fade,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxHeight: 50,
                            ),
                            child: Text(
                              placeAbout,
                              textAlign: TextAlign.start,

                              style: const TextStyle(
                                  fontSize: 14,
                                  overflow: TextOverflow.fade
                              ),
                            ),
                          ),

                          //image of place if place have cover picture
                          // Container(
                          //   height: 50,
                          //   color: ConstColor.widgetsBgGrayColor,
                          //   child: Text("this place for place cover image"),
                          // ),

                          //createdOn and visibility
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              
                              //like button
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  IconButton(
                                    onPressed: ()async{
                                      await likeFunc(widget.uid.toString(),widget.placeId.toString());
                                    },
                                    icon: FaIcon(FontAwesomeIcons.heart,size: 15,),
                                  ),

                                  //like_count
                                  Text(placeLike.toString()),
                                ],
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    DateTimeFormate(publishedDate: placeCreatedOn).getDateFormated().toString(),
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      color: ConstColor.fontLightBlack,
                                    ),
                                  ),
                                ],
                              ),

                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                const Divider()
              ],
            );
          } else {
            return ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 200),
              child: Container(
                decoration: const BoxDecoration(color: ConstColor.widgetsBgGrayColor),
                child: const SizedBox(
                    height: 20,
                    child: Center(child: CircularProgressIndicator())),
              ),
            );
          }
        });
  }
  
  Future likeFunc(String uid, String placeId)async{
    
    
    //check user not like before this time
    
    //add like count in place_likes
    DocumentReference ref = FirebaseFirestore.instance.collection("places").doc(placeId);
    int like=0;
    List? likesUidList ;
    await ref.get().then(
            (ds){
              like = ds["likes"]+1;
              likesUidList =ds["likesUidList"];
              if(likesUidList!=null){
                likesUidList!.add(widget.uid);
              }else{
                likesUidList=[widget.uid];
              }
              ref.update({
                'likes' : like,
                'likesUidList' : likesUidList
              });

            }
    ).onError((error, stackTrace) => AlertMessage(context, Text(error.toString())));

    



  }
  
}
