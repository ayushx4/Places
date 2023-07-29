import 'package:clg_mat/widgets/date_time_formte.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants/const_colors.dart';
import '../pages/show_place.dart';

class ProfilePlacelistDesign extends StatefulWidget {

  String? placeId;
  String? uid;

  ProfilePlacelistDesign({
    required this.placeId,
    required this.uid
  });

  @override
  State<ProfilePlacelistDesign> createState() => _ProfilePlacelistDesignState();
}

class _ProfilePlacelistDesignState extends State<ProfilePlacelistDesign> {
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
            Timestamp placeCreatedOn = snapshot.data!["placeCreatedOn"];

            return Column(
              children: [
                GestureDetector(
                onTap: (){
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context)=>ShowPlace(
                    uid: widget.uid.toString(),
                    placeId:widget.placeId!,
                  ))
              );

            },
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      minWidth: 100,
                      // maxHeight: 600,
                    ),
                    child: Container(
                      decoration: const BoxDecoration(color: ConstColor.bgColor),
                      child: Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,


                          children: [
                            // Text part Place name and place description
                            Text(
                              placeName,
                              textAlign: TextAlign.start,
                              maxLines: 2,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),

                            ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxHeight: 50,
                              ),
                              child: Text(
                                placeAbout,
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300,
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
                            Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    DateTimeFormate(publishedDate:placeCreatedOn).getDateFormated(),
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      color: ConstColor.fontLightBlack,
                                    ),
                                  ),
                                  // const SizedBox(height: 10)
                                ],
                              ),
                            )
                          ],
                        ),
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
}
