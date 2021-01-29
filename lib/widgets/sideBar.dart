import 'package:flutter/material.dart';
import 'package:thender/main.dart';

class SideBar extends StatelessWidget {
  final iconSize = 30.0;
  final textSize = 17.0;
  final iconColorOne = Colors.white;
  final iconColorTwo = HomeScreen().iconBackgroundColour;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 40.0),
            height: 230.0,
            color: iconColorTwo,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 60.0,
                  backgroundColor: iconColorOne,
                  child: CircleAvatar(
                    radius: 55.0,
                    backgroundImage: AssetImage("images/bg.jpg"),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.person,
                    color: iconColorOne,
                    size: iconSize,
                  ),
                  title: Center(
                    child: Text("Serticode",
                    style:  TextStyle(
                      color: iconColorOne,
                      fontSize: 30.0,
                    ),
                    )
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: iconColorOne,
                      size: iconSize,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: iconColorTwo,
              size: iconSize,
            ),
            title: Text(
              'Settings',
              style: TextStyle(
                color: iconColorTwo,
                fontSize: textSize,
              ),
            ),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(
              Icons.share,
              color: iconColorTwo,
              size: iconSize,
            ),
            title: Text(
              'Invite Friends',
              style: TextStyle(
                color: iconColorTwo,
                fontSize: textSize,
              ),
            ),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(
              Icons.info_outline,
              color: iconColorTwo,
              size: iconSize,
            ),
            title: Text(
              'About',
              style: TextStyle(
                color: iconColorTwo,
                fontSize: textSize,
              ),
            ),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(
              Icons.upload_outlined,
              color: iconColorTwo,
              size: iconSize,
            ),
            title: Text(
              'Update to Latest Version',
              style: TextStyle(
                color: iconColorTwo,
                fontSize: textSize,
              ),
            ),
            onTap: () => {Navigator.of(context).pop()},
          ),
          Divider(
            thickness: 3.0,
            color: iconColorTwo,
            indent: 90.0,
            endIndent: 90.0,
          ),
          ListTile(
            leading: Icon(
              Icons.computer_outlined,
              color: iconColorTwo,
              size: iconSize,
            ),
            title: Text(
              'Connect PC',
              style: TextStyle(
                color: iconColorTwo,
                fontSize: textSize,
              ),
            ),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(
              Icons.phone_iphone_outlined,
              color: iconColorTwo,
              size: iconSize,
            ),
            title: Text(
              'Connect iPhone',
              style: TextStyle(
                color: iconColorTwo,
                fontSize: textSize,
              ),
            ),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(
              Icons.star_border_outlined,
              color: iconColorTwo,
              size: iconSize,
            ),
            title: Text(
              'Rate Us',
              style: TextStyle(
                color: iconColorTwo,
                fontSize: textSize,
              ),
            ),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}
