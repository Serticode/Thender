import 'package:flutter/material.dart';
import 'package:thender/main.dart';

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
    return Column(
      children: [
        Container(
          height: 40.0,
          color: Theme.of(context).primaryColor,
          child: ListView.builder(
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
                    horizontal: 15.0,
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
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(top: 3.0),
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
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
        setChild = getPhotosView();
        break;
      case 1:
        setChild = getMusicView();
        break;
      default:
        debugPrint("SWITCH - NO VIEW SELECTED");
    }
    return setChild;
  }

  List<String> getListElements() {
    var items = List<String>.generate(1000, (counter) => "Item $counter");
    return items;
  }

  Widget getPhotosView() {
    var listItems = getListElements();

    var listView = ListView.builder(itemBuilder: (context, index) {
      return ListTile(
        leading: Icon(Icons.add),
        title: Text(listItems[index]),
        subtitle: Text("Random Place Holder: Photos"),
        trailing: Icon(Icons.delete),
      );
    });
    return listView;
  }

  Widget getMusicView() {
    var listItems = getListElements();

    var listView = ListView.builder(itemBuilder: (context, index) {
      return ListTile(
        leading: Icon(Icons.add),
        title: Text(listItems[index]),
        subtitle: Text("Random Place Holder: Music"),
        trailing: Icon(Icons.delete),
      );
    });
    return listView;
  }
}
