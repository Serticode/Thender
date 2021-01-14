import 'package:flutter/material.dart';
import 'package:thender/main.dart';

class ShareHomePage extends StatefulWidget {
  @override
  _ShareHomePageState createState() => _ShareHomePageState();
}

class _ShareHomePageState extends State<ShareHomePage> {
  var homeScreen = HomeScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: homeScreen.iconBackgroundColour,
        shadowColor: homeScreen.textAndIconColour,
        centerTitle: true,
        title: Text(
          'Thender',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.w500,
            color: homeScreen.textAndIconColour,
          ),
        ),
        elevation: 0.0,
      ),
      body: SizedBox.expand(
        child: Container(
          color: homeScreen.otherItemsColour,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Center(
                  child: Text(
                    "Hello World Here's The Share Screen",
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w700,
                      color: homeScreen.iconBackgroundColour,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}