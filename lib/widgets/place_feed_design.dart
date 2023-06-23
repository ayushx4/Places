import 'package:clg_mat/constants/const_colors.dart';
import 'package:clg_mat/widgets/profile_pic_user_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PlaceFeedDesign extends StatefulWidget {
  final String? placeId;

  const PlaceFeedDesign({
    super.key,
    required this.placeId,
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
            String placeAbout = snapshot.data!["placeAbout"];
            String visibility = snapshot.data!["placeVisibility"];
            String placeCreatedOn = snapshot.data!["placeCreatedOn"].toString();

            return Column(
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 100,
                    // maxHeight: 600,
                  ),
                  child: Container(
                    decoration: BoxDecoration(color: ConstColor.bgColor),
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

                          Divider(),

                          // Text part Place name and place description
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical:0),
                                child: Text(
                                  placeName,
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.fade,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight: 50,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  placeAbout,
                                  style: TextStyle(
                                    fontSize: 18,
                                    overflow: TextOverflow.fade
                                  ),
                                ),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                placeCreatedOn.toString(),
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: ConstColor.fontLightBlack,
                                ),
                              ),
                              Text(
                                visibility.toString(),
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: ConstColor.fontLightBlack,
                                ),
                              ),

                              SizedBox(height: 10,)
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                Divider()
              ],
            );
          } else {
            return ConstrainedBox(
              constraints: BoxConstraints(minHeight: 200),
              child: Container(
                decoration: BoxDecoration(color: ConstColor.widgetsBgGrayColor),
                child: SizedBox(
                    height: 20,
                    child: Center(child: CircularProgressIndicator())),
              ),
            );
          }
        });
  }
}
