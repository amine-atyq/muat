import 'package:flutter/material.dart';
import 'package:muat/screens/ArabicScreens/Home/arabic_contact.dart';
import 'package:muat/screens/ArabicScreens/Home/arabic_home_widget.dart';
import 'package:muat/screens/ArabicScreens/arabic_arretes_circulaires_screen.dart';
import 'package:muat/screens/ArabicScreens/arabic_lois_directs_screen.dart';
import 'package:muat/screens/ArabicScreens/arabic_recherche_screen.dart';
import 'package:muat/screens/home_screen.dart';
import 'package:muat/widgets/arabic_main_drawer.dart';

class ArabicHomeScreen extends StatefulWidget {
  const ArabicHomeScreen({super.key});

  @override
  State<ArabicHomeScreen> createState() => _ArabicHomeScreenState();
}

class _ArabicHomeScreenState extends State<ArabicHomeScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) {
    Navigator.of(context).pop();
    if (identifier == 'قوانين ومراسيم') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const ArabicLoisDirectsScreen(),
        ),
      );
    }
    if (identifier == 'قرارات ودوريات') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const ArabicArretesCirculairesScreen(),
        ),
      );
    }
    if (identifier == 'بحث') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const ArabicRechercheScreen(),
        ),
      );
    }
    if (identifier == 'اتصل بنا') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const ArabicHomeScreen(),
        ),
      );
    }
  }

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

    Widget activePage = const ArabicHomeScreenWidget();
    var activePageTitle = 'الصفحة الرئيسية';

    if (_selectedPageIndex == 1) {
      activePage = const ArabicContactScreen();
      activePageTitle = 'اتصل بنا';
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const HomeScreen(),
                  ),
                );
              },
            ),
            const SizedBox(
                width: 8), // Add some spacing between the arrow and title
            Text(activePageTitle),
          ],
        ),
        backgroundColor: const Color(0xFFD3C084),
      ),
      drawer: ArabichMainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            selectedItemColor: Color.fromARGB(255, 222, 211, 177),
            unselectedItemColor: Color(0xFFD3C084),
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
                label: ' الصفحة الرئيسية',
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
    );
  }
}
