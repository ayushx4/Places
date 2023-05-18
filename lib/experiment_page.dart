import 'package:flutter/material.dart';

class Experimentpage extends StatefulWidget {
  const Experimentpage({Key? key}) : super(key: key);

  @override
  State<Experimentpage> createState() => _ExperimentpageState();
}

class _ExperimentpageState extends State<Experimentpage> {

var i=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child:Column(
            children: [
              Text("Click me"),
              Text(i.toString()),
              ElevatedButton(onPressed: (){
                setState(() {
                  i+=1;
                });
              }, child: Text("click"))
            ],
          ),
        ),
      ),
    );
  }
}
