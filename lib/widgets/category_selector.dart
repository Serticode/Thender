import 'dart:ui';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:thender/main.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'gallery.dart';
import 'music.dart';

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
            color: HomeScreen().otherItemsColour,
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

  List<String> getListElements() {
    var items = List<String>.generate(1000, (counter) => "Item $counter");
    return items;
  }

  Widget getFilesView() {
    var listItems = getListElements();

    var listView = ListView.builder(itemBuilder: (context, index) {
      return ListTile(
        leading: CircleAvatar(
          child: Icon(Icons.file_copy_rounded),
          radius: 25.0,
          backgroundColor: HomeScreen().iconBackgroundColour,
          foregroundColor: HomeScreen().textAndIconColour,
        ),
        title: Text(listItems[index]),
        subtitle: Text("Random Place Holder: Files"),
        trailing: Icon(
          Icons.delete,
          color: HomeScreen().iconBackgroundColour,
        ),
      );
    });
    return listView;
  }

  Widget getAppsView() {
    var listItems = getListElements();

    var listView = ListView.builder(itemBuilder: (context, index) {
      return ListTile(
        leading: CircleAvatar(
          child: Icon(Icons.apps_sharp),
          radius: 25.0,
          backgroundColor: HomeScreen().iconBackgroundColour,
          foregroundColor: HomeScreen().textAndIconColour,
        ),
        title: Text(listItems[index]),
        subtitle: Text("Random Place Holder: Apps"),
        trailing: Icon(
          Icons.delete,
          color: HomeScreen().iconBackgroundColour,
        ),
      );
    });
    return listView;
  }
}
