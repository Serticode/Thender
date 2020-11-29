import 'package:flutter/material.dart';
import 'package:thender/main.dart';
import 'package:thender/widgets/category_selector_display.dart';
//import 'category_selector_display.dart';

class CategorySelector extends StatefulWidget {
  @override
  _CategorySelectorState createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  int selectedIndex = 0;
  final List<String> categories = [
    "Photos",
    "Music",
    "Videos",
    "Files",
    "Apps",
  ];
  var homeScreenLink = HomeScreen();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.0,
      color: Theme.of(context).primaryColor,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
                setScreen(selectedIndex);
                //debugPrint(selectedIndex.toString());
              });
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 30.0,
              ),
              child: Text(
                categories[index],
                style: TextStyle(
                  color: index == selectedIndex
                      ? homeScreenLink.textAndIconColour
                      : homeScreenLink.otherItemsColour,
                  fontSize: 25.0,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.0,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

void setScreen (int index) {
  CategorySelectorDisplay();
}
}
