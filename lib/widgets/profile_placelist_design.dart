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
            String placeCreatedOn = snapshot.data!["placeCreatedOn"].toString();

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
                              style: const TextStyle(
                                  fontSize: 18,
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
                              Text(
                                placeCreatedOn.toString(),
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: ConstColor.fontLightBlack,
                                ),
                              ),
                              Text(
                                visibility.toString(),
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: ConstColor.fontLightBlack,
                                ),
                              ),

                              const SizedBox(height: 10,)
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
}
