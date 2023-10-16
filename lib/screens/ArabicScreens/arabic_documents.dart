import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:dio/dio.dart';
import 'package:open_file/open_file.dart';
import 'package:flutter/material.dart';
import 'package:muat/logic/check_permission.dart';
import 'package:muat/logic/directory_path.dart';
import 'package:path/path.dart' as path;

class ArabicDocumnetsScreen extends StatefulWidget {
  const ArabicDocumnetsScreen({
    super.key,
    required this.category,
    required this.subCategory,
  });

  final String category;
  final String subCategory;

  @override
  State<ArabicDocumnetsScreen> createState() => _ArabicDocumnetsScreenState();
}

class _ArabicDocumnetsScreenState extends State<ArabicDocumnetsScreen> {
  var isPermissionGranted = false;
  var checkAllPermissions = CheckPermission();
  var newDocuments = <Map<String, String>>[];

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
    fetchDocuments().then((data) {
      setState(() {
        newDocuments = data;
      });
    });
  }

  Future<List<Map<String, String>>> fetchDocuments() async {
    final url =
        Uri.https('muat-2ab99-default-rtdb.firebaseio.com', 'نصوص.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      if (data.containsKey(widget.category) &&
          data[widget.category].containsKey(widget.subCategory)) {
        final Map<String, dynamic> urbanismeDocuments =
            data[widget.category][widget.subCategory];
        return urbanismeDocuments.values
            .map((doc) => {
                  "id": doc["id"].toString(),
                  "title": doc["title"] as String,
                  "url": doc["url"] as String,
                })
            .toList();
      }
    }
    throw Exception('Failed to load documents');
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: newDocuments.length,
      itemBuilder: (context, index) {
        final document = newDocuments[index];
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
        title: Text(
          widget.subCategory,
          style: const TextStyle(
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
    print("storePath: $storePath");
    filePath = '$storePath/$fileName';

    print("widget.fileUrl: ${widget.fileUrl}");

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
      print("Downloaded");

      setState(() {
        dowloading = false;
        fileExists = true;
      });
    } catch (e) {
      print("Dio Error: $e");
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
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 6,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(widget.title,
                          maxLines: null,
                          overflow: TextOverflow.clip,
                          textDirection: TextDirection.rtl),
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
