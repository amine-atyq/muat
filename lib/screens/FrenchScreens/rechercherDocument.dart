import 'dart:io';

import 'package:dio/dio.dart';
import 'package:open_file/open_file.dart';
import 'package:flutter/material.dart';
import 'package:muat/logic/check_permission.dart';
import 'package:muat/logic/directory_path.dart';
import 'package:path/path.dart' as path;

class rechercheDocumnetsScreen extends StatefulWidget {
  const rechercheDocumnetsScreen({
    super.key,
    required this.newDocuments,
  });
  final List<Map<String, String>> newDocuments;

  @override
  State<rechercheDocumnetsScreen> createState() =>
      _rechercheDocumnetsScreenState();
}

class _rechercheDocumnetsScreenState extends State<rechercheDocumnetsScreen> {
  var isPermissionGranted = false;
  var checkAllPermissions = CheckPermission();

  checkPermission() async {
    var permission = await checkAllPermissions.isStoragePermission();
    if (permission) {
      setState(() {
        isPermissionGranted = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkPermission();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: widget.newDocuments.length,
      itemBuilder: (context, index) {
        final document = widget.newDocuments[index];
        return TitleList(
          fileUrl: document['url']!,
          title: document['title']!,
        );
      },
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color(0xFFD3C084),
        title: const Text(
          'Resultat de Recherche',
          style: TextStyle(
            fontSize: 20, // Adjust the font size as needed
            fontWeight: FontWeight.bold, // Adjust the font weight as needed
            color: Colors.black, // Adjust the text color as needed
          ),
        ),
      ),
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

      setState(() {
        dowloading = false;
        fileExists = true;
      });
    } catch (e) {
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
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(7, 7, 7, 0), // Add vertical spacing
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), // Add rounded corners
          color: const Color.fromARGB(255, 228, 235, 243),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        widget.title,
                        maxLines: null,
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
                            width: 35,
                            child: Icon(
                              Icons.open_in_browser,
                              color: Color.fromARGB(255, 31, 155, 35),
                              size: 35,
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
                                    valueColor:
                                        const AlwaysStoppedAnimation<Color>(
                                            Colors.blue),
                                  ),
                                  Text(
                                    "${(progress * 100).toStringAsFixed(0)}%",
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              )
                            : SizedBox(
                                width: 35,
                                child: Image.asset('assets/images/pdf.png'),
                              ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
