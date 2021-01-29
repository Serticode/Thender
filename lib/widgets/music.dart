import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:thender/main.dart';
import 'package:thender/widgets/share_screen.dart';

class Music extends StatefulWidget {
  @override
  _MusicState createState() => _MusicState();
}

class _MusicState extends State<Music> {
  final FlutterAudioQuery audioQuery = FlutterAudioQuery();
  List<SongInfo> songsList = [];
  var selectedSong;

  _fetchMusic() async {
    final songs = await audioQuery.getSongs(sortType: SongSortType.DEFAULT);

    setState(() => songsList = songs);
  }

  static String formatBytes(int bytes, int decimals) {
    //decimals is to hold how many decimal places the float value should be.
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) +
        ' ' +
        suffixes[i];
  }

  @override
  void initState() {
    _fetchMusic();
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8.0),
      child: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          indent: 75.0,
          color: HomeScreen().iconBackgroundColour,
        ),
        itemCount: songsList.length,
        itemBuilder: (_, index) => Padding(
          padding: EdgeInsets.all(0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30.0,
              backgroundColor: HomeScreen().iconBackgroundColour,
              child: CircleAvatar(
                radius: 25.0,
                backgroundImage: AssetImage("${songsList.elementAt(index).albumArtwork}"),
                //backgroundColor: HomeScreen().textAndIconColour,
              )
              ),
            title: GestureDetector(
              child: Text(
                songsList[index].title,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              onTap: () {
                setState(() {
                  selectedSong = index;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) {
                      /*
                      TODO - Change the return value below, to a music player widget.
                      TODO - create the music player widget.
                      */
                      return ShareHomePage();
                    },
                  ),
                );
                debugPrint("Floating Action Button Pressed.");
              },
            ),
            subtitle: Padding(
              padding: EdgeInsets.only(top: 5.0),
              child: Text(
                formatBytes(int.parse(songsList[index].fileSize), 2),
                style: TextStyle(
                  color: HomeScreen().iconBackgroundColour,
                ),
              ),
            ),
            trailing: Icon(
              Icons.send,
              color: HomeScreen().iconBackgroundColour,
            ),
          ),
        ),
      ),
    );
  }
}
