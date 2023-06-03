import 'package:clg_mat/models/place_model.dart';
import 'package:clg_mat/pages/tabs/place/edit_place.dart';
import 'package:clg_mat/widgets/btn.dart';
import 'package:clg_mat/widgets/custom_input_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

class NewPlacePage extends StatefulWidget {

  String? uid;
  NewPlacePage({
    required this.uid,
});

  @override
  State<NewPlacePage> createState() => _NewPlacePageState();
}

class _NewPlacePageState extends State<NewPlacePage> {
  var placeNameController = TextEditingController();
  var placeAboutController = TextEditingController();
  var visibilityList = ["Public", "Private"];
  String visibilityValue = "Public";



  @override
  void dispose() {
    super.dispose();
    placeNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xFF413636),
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.light,
    ));

    return Scaffold(

      resizeToAvoidBottomInset: true,

      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Color(0xFF413636),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Container(
                  color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Positioned(
                        left: 0,
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () {
                            Navigator.popUntil(context, (route) => route.isFirst);
                          },
                        ),
                      ),
                    )),


                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Create your\nPlace",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Color(0xFFFF4409),
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(
                          height: 20,
                        ),

                        Text(
                          "Save files, pdfs, links\nand share with your\nfriends",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 30,
                            color: Color(0xFFE0E0E0),
                            letterSpacing: 1,
                          ),
                        ),

                        SizedBox(
                          height: 30,
                        ),

                        //visibility field
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                  color: Colors.white70),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: DropdownButton(
                                  value: visibilityValue,
                                  dropdownColor: Colors.white70,
                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                  style: TextStyle(color: Colors.black54,fontSize: 16),
                                  items: visibilityList.map(buildMenuButton).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      this.visibilityValue = value.toString();
                                    });
                                  },
                                ),
                              ),
                            )
                          ],
                        ),

                        SizedBox(height: 10,),

                        //folder name
                        CustomInputFeild(
                          controller: placeNameController,
                          isPassword: false,
                          label: "Folder name",
                        ),

                        SizedBox(height: 10,),

                        // folder about section
                        CustomInputFeild(
                          controller: placeAboutController,
                          isPassword: false,
                          label: "about your place",
                          maxLine: 6,
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


      //create place btn
      floatingActionButton: FloatingActionButton(

        onPressed: () async{
          try{
          if(placeNameController !=null){

            PlaceModel newPlaceModel = PlaceModel(
              uid: widget.uid,
              placeId: Uuid().v4(),
              placeName: placeNameController.text.trim(),
              aboutPlace: placeAboutController.text.trim(),
              visibility: visibilityValue,
              createdOn: DateTime.now(),
            );

           var createPlace = await FirebaseFirestore.instance.collection("places").
                                    doc(newPlaceModel.placeId).set(newPlaceModel.toMap());
           Navigator.pushReplacement(
               context,
               MaterialPageRoute
                 (builder: (context)=>EditPlace(
                   uid: widget.uid.toString(),
                   placeId: newPlaceModel.placeId.toString()
               )));
            
          }}catch (error){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(error.toString()))
            );
          }

        },

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Btn(
            text: "Create place",
            textStyle: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            btnGradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xFFFD9393),
                  Color(0xFFFF4206),
                ]),
            btnShadow: [
              BoxShadow(
                color: Colors.black54,
                offset: const Offset(1.0, 1.0),
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
