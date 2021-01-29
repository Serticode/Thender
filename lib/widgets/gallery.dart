import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:thender/main.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:video_player/video_player.dart';

class Gallery extends StatefulWidget {
  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  List<AssetEntity> assets = [];
  _fetchAssets() async {
    final albums = await PhotoManager.getAssetPathList(onlyAll: true);
    final recentAlbum = albums.first;

    final recentAssets = await recentAlbum.getAssetListRange(
      start: 0,
      end: 1000000,
    );

    setState(() => assets = recentAssets);
  }

  @override
  void initState() {
    _fetchAssets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 2.0,
            crossAxisSpacing: 2.0,
            crossAxisCount: 3,
          ),
          itemCount: assets.length,
          itemBuilder: (_, index) {
            return AssetThumbnail(
              asset: assets[index],
            );
          },
        ),
      ),
    );
  }
}

class AssetThumbnail extends StatelessWidget {
  const AssetThumbnail({
    Key key,
    @required this.asset,
  }) : super(key: key);

  final AssetEntity asset;

  @override
  Widget build(BuildContext context) {
    // We're using a FutureBuilder since thumbData is a future
    return FutureBuilder<Uint8List>(
      future: asset.thumbData,
      builder: (_, snapshot) {
        final bytes = snapshot.data;
        // If we have no data, display a spinner
        if (bytes == null) return CircularProgressIndicator();
        // If there's data, display it as an image
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) {
                  if (asset.type == AssetType.image) {
                    // If this is an image, navigate to ImageScreen
                    return ImageScreen(imageFile: asset.file);
                  } else {
                    // if it's not, navigate to VideoScreen
                    return VideoScreen(videoFile: asset.file);
                  }
                },
              ),
            );
          },
          child: Stack(
            children: [
              // Wrap the image in a Positioned.fill to fill the space
              Positioned.fill(
                child: Image.memory(bytes, fit: BoxFit.cover),
              ),
              // Display a Play icon if the asset is a video
              if (asset.type == AssetType.video)
                Center(
                  child: Container(
                    color: Colors.white,
                    child: Icon(
                      Icons.play_arrow,
                      color: HomeScreen().iconBackgroundColour,
                      size: 35.0,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class ImageScreen extends StatelessWidget {
  const ImageScreen({
    Key key,
    @required this.imageFile,
  }) : super(key: key);

  final Future<File> imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HomeScreen().iconBackgroundColour,
        elevation: 0.0,
        title: Text(
          'Image View',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.w500,
            color: HomeScreen().textAndIconColour,
          ),
        ),
      ),
      body: Container(
        color: Colors.black,
        alignment: Alignment.center,
        child: FutureBuilder<File>(
          future: imageFile,
          builder: (_, snapshot) {
            final file = snapshot.data;
            if (file == null) return Container();
            return GestureDetector(
              child: Image.file(file),
              onDoubleTap: () {
                debugPrint("Image Double Tapped");
              },
            );
          },
        ),
      ),
    );
  }
}

class VideoScreen extends StatefulWidget {
  const VideoScreen({
    Key key,
    @required this.videoFile,
  }) : super(key: key);

  final Future<File> videoFile;

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  VideoPlayerController _controller;
  bool initialized = false;

  @override
  void initState() {
    _initVideo();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _initVideo() async {
    final video = await widget.videoFile;
    _controller = VideoPlayerController.file(video)
      // Play the video again when it ends
      ..setLooping(true)
      // initialize the controller and notify UI when done
      ..initialize().then((_) => setState(() => initialized = true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HomeScreen().iconBackgroundColour,
        shadowColor: HomeScreen().textAndIconColour,
        centerTitle: true,
        title: Text(
          'Video Player',
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.w500,
            color: HomeScreen().textAndIconColour,
          ),
        ),
        elevation: 0.0,
      ),
      body: initialized
          // If the video is initialized, display it
          ? Scaffold(
              body: Center(
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  // Use the VideoPlayer widget to display the video.
                  child: VideoPlayer(_controller),
                ),
              ),
              floatingActionButton: Padding(
                padding: const EdgeInsets.all(15.0),
                child: FloatingActionButton(
                  backgroundColor: HomeScreen().iconBackgroundColour,
                  splashColor: HomeScreen().textAndIconColour,
                  elevation: 10.0,
                  onPressed: () {
                    setState(() {
                      if (_controller.value.isPlaying) {
                        _controller.pause();
                      } else {
                        _controller.play();
                      }
                    });
                  },
                  // Display the correct icon depending on the state of the player.
                  child: Icon(
                    _controller.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                    color: HomeScreen().textAndIconColour,
                    size: 30.0,
                  ),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
            )
          // If the video is not yet initialized, display a spinner
          : Center(child: CircularProgressIndicator()),
    );
  }
}
