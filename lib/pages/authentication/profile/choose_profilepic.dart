import 'dart:io';
import 'package:clg_mat/widgets/alert_message.dart';
import 'package:clg_mat/widgets/btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import '../../../constants/const_colors.dart';
import '../../../models/user_model.dart';
import 'basic_detail.dart';

class ChooseProfilePic extends StatefulWidget {
  UserModel userModel;

  ChooseProfilePic({
    required this.userModel
});

  @override
  State<ChooseProfilePic> createState() => _ChooseProfilePicState();
}

class _ChooseProfilePicState extends State<ChooseProfilePic> {

  File? profileImage ;
  int avatar = 0;

  String defaultMaleAvatar = "assets/images/avatar_male.jpg";
  String defaultFemaleAvatar = "assets/images/avatar_female.jpg";

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: ConstColor.mainColorL2,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: ConstColor.mainColorL2,
        )
    );


    return Scaffold(
      resizeToAvoidBottomInset : false,
      backgroundColor: ConstColor.mainColorL2,
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  //title
                  const Text("Profile",style: TextStyle(fontSize: 20),),
                  const SizedBox(height: 20,),

                  //profile pic
                  Container(
                    height: 200,
                    width: 200,
                    child: Stack(
                        children: [
                          SizedBox(
                              height : 200,
                              width: 200,
                              child: CircleAvatar(
                                backgroundImage: setProfilePic()
                              )
                          ),

                          Positioned(
                              width: 50,
                              height: 50,
                              top: 5,
                              right: 5,
                              child:GestureDetector(
                                onTap: ()async{
                                  selectImage();
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.indigo,
                                    borderRadius: BorderRadius.all(Radius.circular(50)),
                                  ),
                                  child: const Center(
                                    child: FaIcon(FontAwesomeIcons.edit,color: Colors.white,),
                                  ),
                                ),
                              )
                          ),
                        ]
                    ),
                  ),



                  //avatar choice
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        avatarChoice(defaultMaleAvatar),

                        avatarChoice(defaultFemaleAvatar)

                      ],
                    ),
                  ),

                  //next button
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Btn(
                            onTap: (){

                              if(profileImage!=null){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context)=>BasicDetail(
                                          userModel: widget.userModel,
                                          profileImage: profileImage, avatar: avatar, )
                                    ));
                              }else{
                                AlertMessage(context, const Text("Please select any one"));
                              }

                            },

                            text: "Next",
                            textStyle: const TextStyle(color: Colors.white),
                            btnColor: ConstColor.mainColor,
                            btnShadow: const[
                              BoxShadow(
                                color: ConstColor.mainColorL1,
                                offset: Offset(5,5),
                              )
                            ]
                        ),

                      ],
                    ),
                  ),








                ],

              )

          )

      ),

    );

  }
  
  Widget avatarChoice(String selectedAvatar){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        child: CircleAvatar(
          backgroundImage: AssetImage(selectedAvatar),
          radius: 50,
        ),
        onTap: (){
          profileImage=File(selectedAvatar);
          if(selectedAvatar == defaultMaleAvatar){
            avatar=1;//for male
          }else{
            avatar=2;
          }
          setState(() {

          });
        },
      ),
    );
  }

  setProfilePic(){

    if(avatar==1){
      return AssetImage(defaultMaleAvatar);
    }else if(avatar==2){
      return AssetImage(defaultFemaleAvatar);
    } else if(profileImage!=null){
      return FileImage(profileImage!);
    }else{
      return null;
    }

  }

  Future selectImage()async{

    XFile? imageFile;
    imageFile = await ImagePicker().pickImage(source: ImageSource.gallery,) ;
    Navigator.popUntil(context, (route) => route.isFirst);
    print(imageFile.toString());

    if(imageFile==null){
      AlertMessage(context , Text("Someting want wrong"));
    }else{
      final tempImage = File(imageFile.path);
      // CroppedFile? croppedFile = await ImageCropper().cropImage(sourcePath: imageFile!.path);
      setState(() {
        profileImage = tempImage;
        avatar=0;
      });

    }

  }



}
