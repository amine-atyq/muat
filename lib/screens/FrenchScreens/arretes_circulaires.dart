import 'package:flutter/material.dart';
import 'package:muat/data/french_data.dart';
import 'package:muat/screens/FrenchScreens/Home/ContactScreen.dart';
import 'package:muat/screens/FrenchScreens/categoryScreen.dart';

class ArretesCirculairesScreen extends StatefulWidget {
  const ArretesCirculairesScreen({super.key});

  @override
  State<ArretesCirculairesScreen> createState() =>
      _ArretesCirculairesScreenState();
}

class _ArretesCirculairesScreenState extends State<ArretesCirculairesScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  //void _setScreen(String identifier) {}

  @override
  Widget build(BuildContext context) {
    BottomNavigationBarItem _buildBottomNavigationBarItem({
      required IconData icon,
      required String label,
      required int index,
    }) {
      final isSelected = index == _selectedPageIndex;
      final color = isSelected
          ? Color.fromARGB(255, 241, 206, 93) // Selected color
          : Color.fromARGB(255, 171, 143, 51); // Unselected color

      return BottomNavigationBarItem(
        icon: Icon(
          icon,
          color: color,
        ),
        label: label,
      );
    }

    var activePageTitle = 'Arrêtés et Circulaires';

    if (_selectedPageIndex == 1) {
      activePageTitle = 'Contact';
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(activePageTitle),
          backgroundColor: const Color(0xFFD3C084),
          bottom: _selectedPageIndex == 0
              ? const TabBar(
                  labelColor: Colors.black,
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                        width: 2.0,
                        color: Colors.black), // Underline color and thickness
                    insets: EdgeInsets.symmetric(horizontal: 100), // Tab width
                  ),
                  tabs: [
                    Tab(
                      text: 'Arrêtés',
                    ),
                    Tab(
                      text: 'Circulaires',
                    ),
                  ],
                )
              : null,
        ),
        body: TabBarView(
          children: [
            activePageTitle == 'Arrêtés et Circulaires'
                ? CategoryScreen(
                    category: 'Arrêtés', categories: frenchData[2]["content"])
                : const ContactScreen(),
            activePageTitle == 'Arrêtés et Circulaires'
                ? CategoryScreen(
                    category: 'Circulaires',
                    categories: frenchData[3]["content"])
                : const ContactScreen(),
          ],
        ),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
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
                _buildBottomNavigationBarItem(
                  icon: Icons.home,
                  label: 'Accueil',
                  index: 0,
                ),
                _buildBottomNavigationBarItem(
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
}
