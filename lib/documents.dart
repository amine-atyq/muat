import 'dart:io';

import 'package:dio/dio.dart';
import 'package:open_file/open_file.dart';
import 'package:flutter/material.dart';
import 'package:muat/logic/check_permission.dart';
import 'package:muat/logic/directory_path.dart';
import 'package:path/path.dart' as path;

//import 'package:muat/models/document.dart';

class DocumnetsScreen extends StatefulWidget {
  const DocumnetsScreen({super.key});

  @override
  State<DocumnetsScreen> createState() => _DocumnetsScreenState();
}

class _DocumnetsScreenState extends State<DocumnetsScreen> {
  var isPermissionGranted = false;
  var checkAllPermissions = CheckPermission();

  checkPermission() async {
    var permission = await checkAllPermissions.isStoragePermission();
    if (permission) {
      setState(() {
        isPermissionGranted = true;
      });
    }
    print(isPermissionGranted);
  }

  @override
  void initState() {
    super.initState();
    checkPermission();
  }

  var documents = [
    {
      "id": "6",
      "title": "file PDF 6",
      "url":
          "https://www.iso.org/files/live/sites/isoorg/files/store/en/PUB100080.pdf"
    },
    {
      "id": "3",
      "title": "file Video 2",
      "url": "https://download.samplelib.com/mp4/sample-20s.mp4"
    },
    {
      "id": "4",
      "title": "file Video 3",
      "url": "https://download.samplelib.com/mp4/sample-15s.mp4"
    },
    {
      "id": "5",
      "title": "file Video 4",
      "url": "https://download.samplelib.com/mp4/sample-10s.mp4"
    },
    {
      "id": "6",
      "title": "file PDF 6",
      "url":
          "https://www.iso.org/files/live/sites/isoorg/files/store/en/PUB100080.pdf"
    }
  ];

  String fileUrl =
      "https://d3a0uqnd170kn6.cloudfront.net/wp-content/uploads/2022/08/17161051/Random-Mazes.pdf";

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: documents.length,
      itemBuilder: (context, index) {
        final document = documents[index];
        return TitleList(
          fileUrl: document['url']!,
          title: document['title']!,
        );
      },
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title: const Text('Document List'),
          backgroundColor: const Color(0xFFD3C084)),
      body: isPermissionGranted
          ? content
          : Center(
              child: TextButton(
                child: const Text('Permission issue'),
                onPressed: () {
                  checkPermission();
                },
              ),
            ),
    );
  }
}
/*
+
+
+
+
+
+
*/

class TitleList extends StatefulWidget {
  const TitleList({super.key, required this.fileUrl, required this.title});
  final String fileUrl;
  final String title;

  @override
  State<TitleList> createState() => _TitleListState();
}

class _TitleListState extends State<TitleList> {
  bool dowloading = false;
  bool fileExists = false;
  double progress = 0;
  String fileName = "";
  late String filePath;
  // late CancelToken cancelToken;
  var getPathFile = DirectoryPath();

  startDownload() async {
    var storePath = await getPathFile.getPath();
    filePath = '$storePath/$fileName';
    setState(() {
      dowloading = true;
      progress = 0;
    });
    try {
      await Dio().download(
        widget.fileUrl,
        filePath,
        onReceiveProgress: (count, total) {
          setState(() {
            progress = (count / total);
          });
        },
      );
      print('Download Done');
      setState(() {
        dowloading = false;
        fileExists = true;
      });
    } catch (e) {
      print('Exception');
      setState(() {
        dowloading = false;
      });
    }
  }

  checkFileExit() async {
    var storePath = await getPathFile.getPath();
    filePath = '$storePath/$fileName';
    bool fileExistCheck = await File(filePath).exists();
    setState(() {
      fileExists = fileExistCheck;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      fileName = path.basename(widget.fileUrl);
    });
    checkFileExit();
  }

  openfile() {
    OpenFile.open(filePath);
    print("fff $filePath");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: const Color.fromARGB(255, 210, 231, 255),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Row(
            children: [
              const Icon(Icons.insert_drive_file),
              const SizedBox(width: 30),
              Expanded(
                flex: 6, // Takes 60% of the available space
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    '${widget.title} //// ${widget.fileUrl}',
                    maxLines: null, // Allow multi-line text
                    overflow: TextOverflow.clip,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () {
                  fileExists && dowloading == false
                      ? openfile()
                      : startDownload();
                },
                child: fileExists
                    ? const SizedBox(
                        width: 25,
                        child: Icon(
                          Icons.check,
                          color: Colors.green,
                        ),
                      )
                    : dowloading
                        ? Stack(
                            alignment: Alignment.center,
                            children: [
                              CircularProgressIndicator(
                                value: progress,
                                strokeWidth: 3,
                                backgroundColor: Colors.grey,
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                    Colors.blue),
                              ),
                              Text(
                                "${(progress * 100).toStringAsFixed(0)}%",
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          )
                        : SizedBox(
                            width: 25,
                            child: Image.asset('assets/images/pdf.png'),
                          ),
              ),
              const SizedBox(width: 7),
              InkWell(
                onTap: () {
                  startDownload();
                },
                child: SizedBox(
                  width: 25,
                  child: Image.asset('assets/images/word.png'),
                ),
              ),
            ],
          ),
        ),
        const Divider(
          color: Colors.grey,
          height: 1,
        ),
      ],
    );
  }
}
