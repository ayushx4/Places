import 'package:clg_mat/constants/const_colors.dart';
import 'package:clg_mat/pages/add_file_in_place.dart';
import 'package:clg_mat/widgets/file_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'file_open_page.dart';

class ShowPlace extends StatefulWidget {
  final String uid;
  final String placeId;

  ShowPlace(
      {required this.uid, required this.placeId});

  @override
  State<ShowPlace> createState() => _ShowPlaceState();
}

class _ShowPlaceState extends State<ShowPlace> {
        var floatingIcon = Icons.add;
        String currentUserUid = FirebaseAuth.instance.currentUser!.uid.toString();


  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: ConstColor.bgColor,
      statusBarColor: ConstColor.SCWhite,
      statusBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
        appBar: AppBar(
          backgroundColor: ConstColor.bgColor,
          elevation: 0,
          title: const Text(
            "Place",
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              MdiIcons.arrowLeft,
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: ConstColor.bgColor,
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(color: Colors.transparent),
            child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection("places")
                    .doc(widget.placeId)
                    .snapshots(),
                builder: (context, snapshot) {
                  List? fileList = snapshot.data!["fileList"];
                  String placeAbout = snapshot.data!["placeDescription"];
                  return (!snapshot.hasData)
                      ? const Center(
                    child: Text("Something want wrong"),
                  )
                      : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ScrollConfiguration(
                            behavior: const ScrollBehavior(
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
                                    style: const TextStyle(
                                      color: Color(0XFF221A4C),
                                      fontSize: 60,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: ConstrainedBox(
                                      constraints: const BoxConstraints(
                                        maxHeight: 150,
                                        // maxWidth: 20,
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          // color: Colors.red,
                                        ),
                                        child: Text(
                                          (placeAbout == "")
                                              ? "This place is for the Codding Geeks"
                                              : placeAbout,
                                          style: const TextStyle(
                                              color: Colors.black45),
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 30,
                                  ),

                                  //shows file list status
                                  (fileList == null ||
                                      fileList.length == 0)
                                      ? const Card(
                                    child: Text(
                                        "no files are upoded"),
                                  )
                                      : ListView.builder(
                                    physics:
                                    const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: fileList.length,
                                    itemBuilder: (context, index) {

                                      return FileList(fileId: fileList[index]);
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
        floatingActionButton: (currentUserUid!=widget.uid)
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

        // file open function
        fileOpenFunc(String fileId) {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context)=> FileOpenPage())
          );
        }

}

