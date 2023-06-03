import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TabHomePage extends StatefulWidget {
  const TabHomePage({Key? key}) : super(key: key);

  @override
  State<TabHomePage> createState() => _TabHomePageState();
}

class _TabHomePageState extends State<TabHomePage> {
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          systemNavigationBarColor: Color(0xFF4D4545),
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark
        )
    );

    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Container(
            height: 100,
            color: Colors.yellowAccent,
          ),

          Expanded(
            child: SingleChildScrollView(

              child: Column(
                children: [
                  Container(
                    height: 100,
                    color: Colors.red,
                  ),
                  Container(
                    height: 100,
                    color: Colors.blueAccent,
                  ),
                  Container(
                    height: 100,
                    color: Colors.red,
                  ),
                  Container(
                    height: 100,
                    color: Colors.blueAccent,
                  ),
                  Container(
                    height: 100,
                    color: Colors.red,
                  ),
                  Container(
                    height: 100,
                    color: Colors.pink,
                  ),
                  Container(
                    height: 100,
                    color: Colors.blueAccent,
                  ),
                  Container(
                    height: 100,
                    color: Colors.red,
                  ),
                  Container(
                    height: 100,
                    color: Colors.pink,
                  ),
                  Container(
                    height: 100,
                    color: Colors.blueAccent,
                  ),
                ],
              ),
            ),
          )

        ],
      ),
    );
  }
}
