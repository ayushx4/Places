import 'package:flutter/material.dart';

class BasicDetail extends StatefulWidget {
  const BasicDetail({Key? key}) : super(key: key);

  @override
  State<BasicDetail> createState() => _BasicDetailState();
}

class _BasicDetailState extends State<BasicDetail> {

  var usernameController = TextEditingController();
  var bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              //back button

              //title
              const Text("Profile",style: TextStyle(fontSize: 20),),
              const SizedBox(height: 20,),

              //profile pic
              Container(
                height: 200,
                width: 200,
                child: CircleAvatar(),
              ),
              SizedBox(height: 15,),

              //username
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  label: Text("Username"),
                ),
              ),
              SizedBox(height: 15,),

              //bio
              TextField(
                controller: bioController,
                decoration: InputDecoration(
                  label: Text("Bio"),
                ),
              )






            ],


          ),
        ),
      ),
    );
  }
}
