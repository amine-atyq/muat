import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:muat/models/category.dart';
import 'package:muat/screens/FrenchScreens/Home/short_contact_screen.dart';
import 'package:muat/screens/FrenchScreens/categoryScreen.dart';
import 'package:http/http.dart' as http;

class LoisDirectsScreen extends StatefulWidget {
  final String title;
  const LoisDirectsScreen({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<LoisDirectsScreen> createState() => _LoisDirectsScreenState();
}

class _LoisDirectsScreenState extends State<LoisDirectsScreen> {
  int _selectedPageIndex = 0;
  List<Category> lois = [];
  List<Category> directs = [];
  bool categoryFound = true;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  Future<void> fetchSubcategories() async {
    lois = [];
    directs = [];
    final url =
        Uri.https('muat-2ab99-default-rtdb.firebaseio.com', 'documents.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      if (data.containsKey("Lois")) {
        final Map<String, dynamic> loisCategories = data["Lois"];
        loisCategories.forEach((category, items) {
          final int itemCount = (items as Map<String, dynamic>).length;
          lois.add(Category(name: category, count: itemCount));
        });
      } else {
        categoryFound = false;
      }
      if (data.containsKey("Décrets")) {
        final Map<String, dynamic> directsCategories = data["Décrets"];
        directsCategories.forEach((category, items) {
          final int itemCount = (items as Map<String, dynamic>).length;
          directs.add(Category(name: category, count: itemCount));
        });
      } else {
        categoryFound = false;
      }
    } else {
      throw Exception('Échec du chargement des données');
    }
  }

  @override
  Widget build(BuildContext context) {
    var activePageTitle = widget.title;
    BottomNavigationBarItem buildBottomNavigationBarItem({
      required IconData icon,
      required String label,
      required int index,
    }) {
      final isSelected = index == _selectedPageIndex;
      final color = isSelected
          ? const Color.fromARGB(255, 241, 206, 93) // Selected color
          : const Color.fromARGB(255, 171, 143, 51); // Unselected color
      return BottomNavigationBarItem(
        icon: Icon(
          icon,
          color: color,
        ),
        label: label,
      );
    }

    if (_selectedPageIndex == 1) {
      activePageTitle = 'Contact';
    }

    return FutureBuilder<void>(
        future: fetchSubcategories(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // If the Future is still running, return a loading indicator
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ); // You can replace this with your own loading widget
          } else if (snapshot.hasError) {
            // If we encounter an error, display an error message
            return Scaffold(
              body: Center(
                child: Text('Error: ${snapshot.error}'),
              ),
            );
          } else {
            return DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: AppBar(
                  title: Text(
                    activePageTitle,
                    style: const TextStyle(
                      fontSize: 20, // Adjust the font size as needed
                      fontWeight:
                          FontWeight.bold, // Adjust the font weight as needed
                      color: Colors.black, // Adjust the text color as needed
                    ),
                  ),
                  backgroundColor: const Color(0xFFD3C084),
                  bottom: _selectedPageIndex == 0
                      ? const PreferredSize(
                          preferredSize: Size.fromHeight(
                              48), // Adjust the preferred size as needed
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20), // Adjust horizontal padding
                            child: TabBar(
                              labelColor:
                                  Colors.black, // Adjust the label color
                              unselectedLabelColor: Color.fromARGB(249, 0, 0,
                                  0), // Adjust the unselected label color
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight
                                      .bold), // Make selected label bold
                              indicator: UnderlineTabIndicator(
                                borderSide: BorderSide(
                                  width: 2.0,
                                  color: Colors.black,
                                ),
                              ),
                              tabs: [
                                Tab(
                                  text: 'Lois',
                                ),
                                Tab(
                                  text: 'Décrets',
                                ),
                              ],
                            ),
                          ),
                        )
                      : null,
                ),
                body: TabBarView(
                  children: [
                    activePageTitle == 'Lois et Décrets'
                        ? CategoryScreen(
                            category: 'Lois',
                            categories: lois.reversed.toList())
                        : const ShortContactScreen(),
                    activePageTitle == 'Lois et Décrets'
                        ? CategoryScreen(
                            category: 'Décrets',
                            categories: directs.reversed.toList())
                        : const ShortContactScreen(),
                  ],
                ),
                bottomNavigationBar: Theme(
                  data: Theme.of(context).copyWith(
                    bottomNavigationBarTheme:
                        const BottomNavigationBarThemeData(
                      selectedItemColor: Color.fromARGB(255, 241, 206, 93),
                      unselectedItemColor: Color.fromARGB(255, 171, 143, 51),
                    ),
                  ),
                  child: SizedBox(
                    height: 70,
                    child: BottomNavigationBar(
                      onTap: _selectPage,
                      currentIndex: _selectedPageIndex,
                      backgroundColor: const Color(0xFF004595),
                      items: [
                        buildBottomNavigationBarItem(
                          icon: Icons.home,
                          label: 'Accueil',
                          index: 0,
                        ),
                        buildBottomNavigationBarItem(
                          icon: Icons.perm_contact_cal,
                          label: 'Contact',
                          index: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        });
  }
}
