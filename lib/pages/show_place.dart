import 'package:clg_mat/constants/const_colors.dart';
import 'package:clg_mat/pages/add_file_in_place.dart';
import 'package:clg_mat/pages/home/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ShowPlace extends StatefulWidget {
  final String uid;
  final String placeId;
  final bool isViwersPlace;

  ShowPlace(
      {required this.uid, required this.placeId, required this.isViwersPlace});

  @override
  State<ShowPlace> createState() => _ShowPlaceState();
}

class _ShowPlaceState extends State<ShowPlace> {
  var floatingIcon = Icons.add;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: ConstColor.bgColor,
      statusBarColor: ConstColor.bgColor,
      statusBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      backgroundColor: ConstColor.bgColor,
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent
            ),
            child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection("places")
                    .doc(widget.placeId)
                    .snapshots(),
                builder: (context, snapshot) {
                  List? fileList = snapshot.data!["fileList"];
                  String placeAbout = snapshot.data!["placeAbout"];
                  return (!snapshot.hasData)
                      ? Center(
                          child: Container(
                            child: Text("Something want wrong"),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Expanded(
                                child: ScrollConfiguration(
                                  behavior: ScrollBehavior(
                                      androidOverscrollIndicator:
                                          AndroidOverscrollIndicator.stretch),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        //Place name from firebase
                                        Text(
                                          snapshot.data!["placeName"],
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 60,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: ConstrainedBox(
                                            constraints: BoxConstraints(
                                              maxHeight: 150,
                                              // maxWidth: 20,
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  // color: Colors.red,
                                                  ),
                                              child: Text(
                                                (placeAbout=="") ?
                                                "This place is for the Codding Geeks"
                                                : placeAbout,
                                                style: TextStyle(
                                                    color: Colors.black45),
                                              ),
                                            ),
                                          ),
                                        ),

                                        SizedBox(
                                          height: 30,
                                        ),

                                        //shows file list status
                                        (fileList == null ||
                                                fileList.length == 0)
                                            ? Card(
                                                child: Text(
                                                    "no files are uploded"),
                                              )
                                            : ListView.builder(
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: fileList.length,
                                                itemBuilder: (context, index) {
                                                  String fileId = fileList[index];
                                                  return GestureDetector(
                                                    onTap: fileOpenFunc(fileId),
                                                    child: Card(
                                                      color: Colors.white70,
                                                      child: ListTile(
                                                        title: Text(
                                                          fileId,
                                                          style: TextStyle(
                                                              color: ConstColor.dataColor,
                                                              fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                        leading: Icon(
                                                          Icons.picture_as_pdf,
                                                          color: ConstColor
                                                              .mainColor,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                }),
          ),
        ),

        //add field button
        floatingActionButton: (!widget.isViwersPlace)
            ? null
            : FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddFileInPlace(
                              uid: widget.uid,
                              placeId: widget.placeId,
                            )),
                  );
                },
          backgroundColor: ConstColor.mainColor,
          child: Icon(MdiIcons.plus),
              ));
  }

  //file open function
  fileOpenFunc(String fileId) {}
}
