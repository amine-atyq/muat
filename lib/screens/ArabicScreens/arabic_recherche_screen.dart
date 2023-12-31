import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:muat/screens/FrenchScreens/rechercherDocument.dart';

class ArabicRechercheScreen extends StatefulWidget {
  const ArabicRechercheScreen({Key? key}) : super(key: key);

  @override
  _ArabicRechercheScreenState createState() => _ArabicRechercheScreenState();
}

class _ArabicRechercheScreenState extends State<ArabicRechercheScreen> {
  final _searchController = TextEditingController();
  List<Map<String, String>> filteredDocuments = [];
  List<Map<String, String>> newDocuments = [];

  @override
  void initState() {
    super.initState();
    fetchDocuments();
  }

  Future<void> fetchDocuments() async {
    final url =
        Uri.https('muat-2ab99-default-rtdb.firebaseio.com', 'نصوص.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      if (data.containsKey("Lois")) {
        final Map<String, dynamic> loisCategories = data["Lois"];
        loisCategories.forEach((category, items) {
          if (items is Map<String, dynamic>) {
            items.forEach((documentId, documentData) {
              final String title = documentData["title"];
              final String url = documentData["url"];
              newDocuments.add({
                "title": title,
                "url": url,
              });
            });
          }
        });
      }

      if (data.containsKey("Directs")) {
        final Map<String, dynamic> directsCategories = data["Directs"];
        directsCategories.forEach((category, items) {
          if (items is Map<String, dynamic>) {
            items.forEach((documentId, documentData) {
              final String title = documentData["title"];
              final String url = documentData["url"];
              newDocuments.add({
                "title": title,
                "url": url,
              });
            });
          }
        });
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  void filterDocuments(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredDocuments = newDocuments;
      });
    } else {
      setState(() {
        filteredDocuments = newDocuments
            .where((doc) =>
                doc['title']!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFD3C084),
        title: const Text(
          'البحث',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _searchController,
              onChanged: (query) => filterDocuments(query),
              decoration: InputDecoration(
                labelText: 'بحث',
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    color: Color(0xFF004595), // لون الحدود
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) =>
                      RechercheDocumnetsScreen(newDocuments: filteredDocuments),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              primary: const Color(0xFF004595),
              onPrimary: Colors.white,
            ),
            child: const Text(
              "البحث",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: filteredDocuments.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(filteredDocuments[index]['title'] ?? ''),
                  onTap: () async {
                    // أضف هنا منطق التحميل والفتح الخاص بك
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
