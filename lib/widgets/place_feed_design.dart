import 'package:clg_mat/constants/const_colors.dart';
import 'package:clg_mat/pages/show_place.dart';
import 'package:clg_mat/widgets/alert_message.dart';
import 'package:clg_mat/widgets/profile_pic_user_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

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
        builder: (context, placeSnapshot) {

          if(placeSnapshot.connectionState== ConnectionState.active){
            if (placeSnapshot.hasData) {
              String uid = placeSnapshot.data!["uid"];
              String placeName = placeSnapshot.data!["placeName"];
              String placeAbout = placeSnapshot.data!["placeDescription"];
              String visibility = placeSnapshot.data!["placeVisibility"];
              List? placeLikeList = placeSnapshot.data!["likesUidList"];
              int placeLike = (placeLikeList==null) ? 0 : placeLikeList.length;
              Timestamp placeCreatedOn = placeSnapshot.data!["placeCreatedOn"];

              return Column(
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      minWidth: 100,
                      // maxHeight: 600,
                    ),
                    child: Container(
                      decoration: const BoxDecoration(color: Colors.transparent),
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

                              //place_name
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical:0),
                                    child: Text(
                                      placeName,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    placeAbout,
                                    textAlign: TextAlign.start,

                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        overflow: TextOverflow.fade
                                    ),
                                  ),

                                  IconButton(
                                    onPressed: ()async{
                                    // await openLink();
                                  },
                                    icon: Icon(Icons.link),
                                  )
                                ],
                              ),
                            ),

                            //image of place if place have cover picture
                            // Container(
                            //   height: 50,
                            //   color: ConstColor.widgetsBgGrayColor,
                            //   child: Text("this place for place cover image"),
                            // ),

                            //createdOn and visibility
                            IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  //like button
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: ()async{
                                          await likeFunc(widget.uid.toString(),widget.placeId.toString());
                                        },
                                        icon: FaIcon(FontAwesomeIcons.heart,size: 15,),
                                      ),

                                      //like_count
                                      Text(placeLike.toString()),

                                      const SizedBox(width: 5),

                                      IconButton(
                                          onPressed: (){
                                            sharePlace();
                                          },
                                          icon:const Icon(Icons.share_outlined)
                                      ),

                                    ],
                                  ),

                                  Text(
                                    DateTimeFormate(publishedDate: placeCreatedOn).getDateFormated(),
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      color: ConstColor.fontLightBlack,
                                    ),
                                  ),

                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  const Divider()
                ],
              );
            } else if(placeSnapshot.hasError) {
              return AlertMessage(context, Text(placeSnapshot.error.toString()));
            }else{
              return const Center(child: Text('something want wrong'));
            }
          }else{
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

    bool userLiked = false;
    DocumentReference ref = FirebaseFirestore.instance.collection("places").doc(placeId);
    //check whether user liked this file or not

    //add like

    List? likesUidList ;
    await ref.get().then(
            (ds){
          likesUidList =ds["likesUidList"];
          if(likesUidList!=null){
            likesUidList!.add(widget.uid);
          }else{
            likesUidList=[widget.uid];
          }
          ref.update({
            'likesUidList' : likesUidList
          });

        }
    ).onError((error, stackTrace) => AlertMessage(context, Text(error.toString())));

    if(userLiked){

    }else{
      //remove like
    }





  }

  void sharePlace() {
    //share place
  }

  // Future openLink(Uri url)async{
  //   try{
  //     await launchUrl(
  //         url,
  //         mode: LaunchMode.externalNonBrowserApplication,
  //         webViewConfiguration: const WebViewConfiguration(enableJavaScript: false)
  //     );
  //   }catch(error){
  //     AlertMessage(context, Text(error.toString()));
  //   }
  // }

}
