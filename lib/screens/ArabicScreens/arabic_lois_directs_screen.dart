import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:muat/models/category.dart';
import 'package:muat/data/french_data.dart';
import 'package:muat/screens/ArabicScreens/Home/arabic_contact.dart';
import 'package:muat/screens/ArabicScreens/arabic_category_screen.dart';
import 'package:http/http.dart' as http;

import 'package:muat/screens/FrenchScreens/Home/ContactScreen.dart';

class ArabicLoisDirectsScreen extends StatefulWidget {
  final String title;
  const ArabicLoisDirectsScreen({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<ArabicLoisDirectsScreen> createState() =>
      _ArabicLoisDirectsScreenState();
}

class _ArabicLoisDirectsScreenState extends State<ArabicLoisDirectsScreen> {
  int _selectedPageIndex = 0;
  List<Category> lois = [];
  List<Category> directs = [];
  bool categoryFound = true;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  Future<void> arabicSubcategories() async {
    lois = [];
    directs = [];
    final url =
        Uri.https('muat-2ab99-default-rtdb.firebaseio.com', 'نصوص.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      if (data.containsKey("قوانين")) {
        final Map<String, dynamic> loisCategories = data["قوانين"];
        loisCategories.forEach((category, items) {
          final int itemCount = (items as Map<String, dynamic>).length;
          lois.add(Category(name: category, count: itemCount));
        });
      } else {
        categoryFound = false;
      }
      if (data.containsKey("مراسيم")) {
        final Map<String, dynamic> directsCategories = data["مراسيم"];
        directsCategories.forEach((category, items) {
          final int itemCount = (items as Map<String, dynamic>).length;
          directs.add(Category(name: category, count: itemCount));
        });
      } else {
        categoryFound = false;
      }
    } else {
      throw Exception('فشل في تحميل البيانات');
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
      activePageTitle = 'اتصل بنا';
    }

    return FutureBuilder<void>(
        future: arabicSubcategories(),
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
                    textDirection: TextDirection.rtl,
                    // Align text to the right
                  ),
                  centerTitle: false,
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
                                  text: 'قوانين',
                                ),
                                Tab(
                                  text: 'مراسيم',
                                ),
                              ],
                            ),
                          ),
                        )
                      : null,
                ),
                body: TabBarView(
                  children: [
                    activePageTitle == 'قوانين ومراسيم'
                        ? ArabicCategoryScreen(
                            category: 'قوانين',
                            categories: lois.reversed.toList())
                        : const ArabicContactScreen(),
                    activePageTitle == 'قوانين ومراسيم'
                        ? ArabicCategoryScreen(
                            category: 'مراسيم',
                            categories: directs.reversed.toList())
                        : const ArabicContactScreen(),
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
                          label: 'استقبال',
                          index: 0,
                        ),
                        buildBottomNavigationBarItem(
                          icon: Icons.perm_contact_cal,
                          label: 'اتصل بنا',
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
