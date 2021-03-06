import 'package:flutter/material.dart';
import 'package:thender/widgets/category_selector.dart';
import 'package:thender/widgets/category_selector_display.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Thender",
      theme: ThemeData(
        primaryColor: Color(0xff14213d),
        accentColor:  Color(0xffe5e5e5),
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  //const HomeScreen({Key key}) : super(key: key);

  final Color textAndIconColour = Color(0xfffca311);
  final Color iconBackgroundColour = Color(0xff14213d);
  final Color otherItemsColour = Color(0xffe5e5e5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: iconBackgroundColour,
        shadowColor: textAndIconColour,
        title: Text(
          'Thender',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.w700,
            color: textAndIconColour,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(15.0),
        child: FloatingActionButton(
          elevation: 10.0,
          backgroundColor:iconBackgroundColour,
          splashColor: textAndIconColour,
          child: Icon(
            Icons.share,
            color: textAndIconColour,
            size: 30.0,
          ),
          tooltip: "Connect ?",
          onPressed: () {
            debugPrint("Floating Action Button Pressed.");
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Column(
        children: [
          CategorySelector(), // CATEGORIES LIST.
          CategorySelectorDisplay(), // SCREEN FOR EACH MEMBER OF THE LIST.
        ],
      ),
    );
  }
}