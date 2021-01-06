import 'package:flutter/material.dart';
import 'package:thender/widgets/category_selector.dart';
import 'package:thender/widgets/share_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Thender",
      theme: ThemeData(
        primaryColor: Color(0xff14213d),
        accentColor: Color(0xff14213d), //Color(0xffe5e5e5),
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
        centerTitle: true,
        title: Text(
          'Thender',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.w500,
            color: textAndIconColour,
          ),
        ),
        elevation: 0.0,
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(15.0),
        child: FloatingActionButton(
          elevation: 10.0,
          backgroundColor: iconBackgroundColour,
          splashColor: textAndIconColour,
          child: Icon(
            Icons.share,
            color: textAndIconColour,
            size: 30.0,
          ),
          tooltip: "Connect ?",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) {
                  return ShareHomePage();
                },
              ),
            );
            debugPrint("Floating Action Button Pressed.");
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SizedBox.expand(
        child: Container(
          color: iconBackgroundColour,
          child: CategorySelector(),
        ),
      ),
    );
  }
}
