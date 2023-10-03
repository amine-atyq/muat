import 'package:flutter/material.dart';
import 'package:muat/data/french_data.dart';
import 'package:muat/screens/FrenchScreens/Home/ContactScreen.dart';
import 'package:muat/screens/FrenchScreens/categoryScreen.dart';

class ArabicArretesCirculairesScreen extends StatefulWidget {
  const ArabicArretesCirculairesScreen({super.key});

  @override
  State<ArabicArretesCirculairesScreen> createState() =>
      _ArabicArretesCirculairesScreenState();
}

class _ArabicArretesCirculairesScreenState
    extends State<ArabicArretesCirculairesScreen> {
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

    var activePageTitle = 'قوانين ومراسيم';

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
                      text: 'قوانين',
                    ),
                    Tab(
                      text: 'مراسيم',
                    ),
                  ],
                )
              : null,
        ),
        body: TabBarView(
          children: [
            activePageTitle == 'قوانين ومراسيم'
                ? CategoryScreen(
                    category: 'قوانين', categories: frenchData[2]["content"])
                : const ContactScreen(),
            activePageTitle == 'قوانين ومراسيم'
                ? CategoryScreen(
                    category: 'مراسيم', categories: frenchData[3]["content"])
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
                  label: "الصفحة الرئيسية",
                  index: 0,
                ),
                _buildBottomNavigationBarItem(
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
}
