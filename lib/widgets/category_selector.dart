import 'dart:ui';
import 'dart:io';
import 'files.dart';
import 'gallery.dart';
import 'music.dart';
import 'apps.dart';
import 'package:flutter/material.dart';
import 'package:thender/main.dart';

class CategorySelector extends StatefulWidget {
  @override
  _CategorySelectorState createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  int selectedIndex = 0;
  File imageFile;
  var homeScreenLink = HomeScreen();
  final List<String> categories = [
    "Gallery",
    "Music",
    "Files",
    "Apps",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50.0,
          color: Theme.of(context).primaryColor,
          child: ListView.builder(
            padding: EdgeInsets.only(left: 18),
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  child: Text(
                    categories[index],
                    textAlign: TextAlign.justify,
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
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: HomeScreen().otherItemsColour,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0),
              ),
            ),
            child: getView(selectedIndex),
          ),
        ),
      ],
    );
  }

  Widget getView(int index) {
    Widget setChild;
    switch (index) {
      case 0:
        setChild = getGallery();
        break;
      case 1:
        setChild = getMusic();
        break;
      case 2:
        setChild = getFilesView();
        break;
      case 3:
        setChild = getAppsView();
        break;
      default:
        debugPrint("SWITCH - NO VIEW SELECTED");
    }
    return setChild;
  }

  Widget getGallery() => Gallery();
  Widget getMusic() => Music();
  Widget getFilesView() => Files();
  Widget getAppsView() => Files();
}
