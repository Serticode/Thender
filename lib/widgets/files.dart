import 'dart:io';
import '../main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_manager/flutter_file_manager.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'package:path_provider_ex/path_provider_ex.dart';
import 'package:open_file/open_file.dart';
import 'dart:async';

class Files extends StatefulWidget {
  @override
  _FilesState createState() => _FilesState();
}

class _FilesState extends State<Files> {
  var files;

  void getFiles() async {
    //async function to get list of files
    List<StorageInfo> storageInfo = await PathProviderEx.getStorageInfo();

    //getting the root directory - use storageInfo[1] for SD card;
    var root = storageInfo[0].rootDir;

    var fileManager = FileManager(
      root: Directory(root),
    );

    files = await fileManager.filesTree(
      //set fm.dirsTree() for directory/folder tree list
      excludedPaths: ["/storage/emulated/0/Android"],
      extensions: [
        "txt",
        "pdf",
        "docx",
        "doc",
        "xls",
        "xlsx",
        "ppt",
        "pot",
        "pptx",
        "apk"
      ], //optional, to filter files, remove to list all,
      //remove the extensions parameter if your are grabbing folder list
      sortedBy: FileManagerSorting.Type,
    );

    setState(() {}); //update the UI
  }

  @override
  void initState() {
    getFiles(); //call getFiles() function on initial state.
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8.0),
      child: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          indent: 75.0,
          color: HomeScreen().iconBackgroundColour,
        ),
        itemCount: files?.length ?? 0,
        itemBuilder: (_, index) => Padding(
          padding: EdgeInsets.all(0),
          child: ListTile(
            leading: CircleAvatar(
              child: CircleAvatar(
                radius: 25.0,
                backgroundColor: HomeScreen().textAndIconColour,
                foregroundColor: HomeScreen().iconBackgroundColour,
                child: files.elementAt(index).path.split('.').last == "pdf"
                    ? Icon(
                        Icons.picture_as_pdf_outlined,
                        size: 30.0,
                      )
                    : Icon(
                        Icons.file_copy_outlined,
                        size: 30.0,
                      ), // file_copy_rounded),
              ),
              radius: 30.0,
              backgroundColor: HomeScreen().iconBackgroundColour,
              foregroundColor: HomeScreen().textAndIconColour,
            ),
            title: GestureDetector(
              child: Text(
                files.elementAt(index).path.split('/').last,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            onTap: () {
              files.elementAt(index).path.split('.').last == "pdf"
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) {
                          return ViewPDF(
                              pathPDF: files.elementAt(index).path.toString());
                        },
                      ),
                    )
                  : Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return ViewDocuments(
                          filePath: files.elementAt(index).path.toString());
                    }));
            },
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

class ViewPDF extends StatelessWidget {
  final pathPDF;
  ViewPDF({this.pathPDF});

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
        //view PDF
        appBar: AppBar(
          title: Text(
            "Document",
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.w500,
              color: HomeScreen().textAndIconColour,
            ),
          ),
          backgroundColor: HomeScreen().iconBackgroundColour,
        ),
        path: pathPDF);
  }
}

class ViewDocuments extends StatefulWidget {
  final String filePath;

  ViewDocuments({key: Key, this.filePath});

  @override
  _ViewDocumentsState createState() => _ViewDocumentsState();
}

class _ViewDocumentsState extends State<ViewDocuments> {
  var openedFile = 'Unknown';

  Future<void> openFile() async {
    final filePath = widget.filePath;

    final result = await OpenFile.open(filePath);

    setState(() {
      openedFile = "type=${result.type}  message=${result.message}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Document",
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.w500,
            color: HomeScreen().textAndIconColour,
          ),
        ),
        backgroundColor: HomeScreen().iconBackgroundColour,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: FlatButton(
              padding: EdgeInsets.all(15.0),
              color: HomeScreen().iconBackgroundColour,
              textColor: HomeScreen().otherItemsColour,
              child: Text(
                'Tap to open file',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w500,
                  color: HomeScreen().textAndIconColour,
                ),
              ),
              onPressed: openFile,
            ),
          ),
        ],
      ),
    );
  }
}
