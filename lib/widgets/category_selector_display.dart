import 'package:flutter/material.dart';
import 'package:thender/main.dart';

class CategorySelectorDisplay extends StatefulWidget {
  @override
  _CategorySelectorDisplay createState() => _CategorySelectorDisplay();
  final objectCatSelDisplay = _CategorySelectorDisplay();

  void setRecievedIndex (int index) {
    objectCatSelDisplay._recievedIndex = index;
  }
}

class _CategorySelectorDisplay extends State<CategorySelectorDisplay> {
  int _recievedIndex;
  var homeScreenLink = HomeScreen();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(top: 3.0),
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.0),
            topRight: Radius.circular(40.0),
          ),
        ),
        child: getView(),
      ),
    );
  }

/*
lol, you know i'm weird and i'd do what i want anyways.
just want to let you know that i draw strength from your persistence towards what you love the most.
I see you doing great things and i can't wait to see it unfold. love you always, HUNNAE. xoxo..
*/

Widget getView () {
  Widget setChild;
  debugPrint(_recievedIndex.toString() + " || Hello GetView Debug");
  switch (_recievedIndex) {
    case 0: setChild = getPhotosView();
    break;
    case 1: setChild = getMusicView();
    break;
    default : debugPrint("SWITCH - NO VIEW SELECTED");
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