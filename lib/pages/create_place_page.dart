import 'package:clg_mat/constants/const_colors.dart';
import 'package:clg_mat/models/place_model.dart';
import 'package:clg_mat/pages/show_place.dart';
import 'package:clg_mat/widgets/btn.dart';
import 'package:clg_mat/widgets/custom_input_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';


class CreatePlacePage extends StatefulWidget {
  String? uid;
  CreatePlacePage({
    required this.uid,
  });

  @override
  State<CreatePlacePage> createState() => _CreatePlacePageState();
}

class _CreatePlacePageState extends State<CreatePlacePage> {
  TextEditingController placeNameController = TextEditingController();
  TextEditingController placeAboutController = TextEditingController();
  var visibilityList = ["Public", "Private"];
  String visibilityValue = "Public";

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor:ConstColor.SCWhite ,
      statusBarColor: ConstColor.SCWhite,
      statusBarIconBrightness: Brightness.light,
    ));

    return Scaffold(
      resizeToAvoidBottomInset: true,

      body: Scaffold(
        backgroundColor: ConstColor.bgColor,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: ConstColor.bgColor,
          title: const Text(
            "Create place",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            // decoration: BoxDecoration(
            //   color: Color(0xFF413636),
            // ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //visibility field
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                height: 30,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    color: Colors.white70),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: DropdownButton(
                                    value: visibilityValue,
                                    dropdownColor: Colors.white70,
                                    borderRadius:
                                        const BorderRadius.all(Radius.circular(8)),
                                    style: const TextStyle(
                                        color: Colors.black54, fontSize: 16),
                                    items: visibilityList
                                        .map(buildMenuButton)
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        visibilityValue = value.toString();
                                      });
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          //folder name
                          CustomInputFeild(
                            controller: placeNameController,
                            isPassword: false,
                            label: "Place name",
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          // folder about section
                          CustomInputFeild(
                            controller: placeAboutController,
                            isPassword: false,
                            label: "Describe your place",
                            maxLine: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      //create place btn
      floatingActionButton: InkWell(
        onTap: () async {
          String placeName = placeNameController.text.trim();
          String placeAbout = placeAboutController.text.trim();

          try {
            if (placeName != "") {
              String placeId = Uuid().v4();
              PlaceModel newPlaceModel = PlaceModel(
                uid: widget.uid,
                placeId: placeId,
                placeName: placeName,
                placeDescription: placeAbout,
                likes: 0,
                placeVisibility: visibilityValue,
                placeCreatedOn: DateTime.now(),
              );

              var createPlace = await FirebaseFirestore.instance
                  .collection("places")
                  .doc(newPlaceModel.placeId)
                  .set(newPlaceModel.toMap());

              //add places list in users_places_detail model

              List? placesList;

              DocumentReference usersPlacesDetailRef = FirebaseFirestore.instance
                  .collection("usersPlacesDetail")
                  .doc(widget.uid);
              await FirebaseFirestore.instance
                  .collection("usersPlacesDetail")
                  .doc(widget.uid)
                  .get()
                  .then((ds) {
                placesList = ds.data()!["placesList"];
                if (placesList != null) {
                  placesList!.add(placeId);
                } else {
                  placesList = [placeId];
                }
              });

              await usersPlacesDetailRef.update({
                "placesList": placesList
              });

              Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ShowPlace(
                            uid: widget.uid.toString(),
                            placeId: newPlaceModel.placeId.toString(),
                          )));
            }
          } catch (error) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(error.toString())));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Btn(
            text: "Create",
            textStyle: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            btnGradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.centerRight,
                colors: [
                  // Color(0xFFFD9393),
                  // Color(0xFFFF4206),
                  ConstColor.mainColor,
                  ConstColor.mainColor
                ]),
            btnShadow:const [
              BoxShadow(
                color: Colors.black54,
                offset: Offset(1.0, 1.0),
                blurRadius: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuButton(String item) {
    return DropdownMenuItem(value: item, child: Text(item));
  }
}
