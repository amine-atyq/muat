import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:muat/screens/FrenchScreens/rechercherDocument.dart';

class RechercheScreen extends StatefulWidget {
  const RechercheScreen({Key? key}) : super(key: key);

  @override
  _RechercheScreenState createState() => _RechercheScreenState();
}

class _RechercheScreenState extends State<RechercheScreen> {
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
        Uri.https('muat-2ab99-default-rtdb.firebaseio.com', 'documents.json');
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
          'Recherche',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _searchController,
              onChanged: (query) => filterDocuments(query),
              decoration: InputDecoration(
                labelText: 'Recherche',
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: const Color(0xFF004595), // Added border color
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
                      rechercheDocumnetsScreen(newDocuments: filteredDocuments),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              primary: const Color(0xFF004595),
              onPrimary: Colors.white,
            ),
            child: const Text(
              "Recherche",
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
                    // Add your download and open logic here
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
