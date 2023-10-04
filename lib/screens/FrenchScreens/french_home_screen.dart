import 'package:flutter/material.dart';
import 'package:muat/screens/FrenchScreens/Home/AcceuilScreen.dart';
import 'package:muat/screens/FrenchScreens/Home/ContactScreen.dart';
import 'package:muat/screens/FrenchScreens/arretes_circulaires.dart';
import 'package:muat/screens/FrenchScreens/lois_decrets_screen.dart';
import 'package:muat/screens/FrenchScreens/recherche_screen.dart';
import 'package:muat/screens/home_screen.dart';

import 'package:muat/widgets/french_main_drawer.dart';

class FrenchHomeScreen extends StatefulWidget {
  const FrenchHomeScreen({super.key});

  @override
  State<FrenchHomeScreen> createState() => _FrenchHomeScreenState();
}

class _FrenchHomeScreenState extends State<FrenchHomeScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) {
    Navigator.of(context).pop();
    if (identifier == 'Lois et Décrets') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const LoisDirectsScreen(
            title: 'Lois et Décrets',
          ),
        ),
      );
    }
    if (identifier == 'Arrêtés et Circulaires') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const ArretesCirculairesScreen(),
        ),
      );
    }
    if (identifier == 'Recherche') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const RechercheScreen(),
        ),
      );
    }
    if (identifier == 'Contact') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const ContactScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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

    Widget activePage = const AccueilScreen();
    var activePageTitle = 'Accueil';

    if (_selectedPageIndex == 1) {
      activePage = const ContactScreen();
      activePageTitle = 'Contact';
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFD3C084),
        title: Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back, size: 24,
                color: Colors.black87, // Adjust color and size
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const HomeScreen(),
                  ),
                );
              },
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                activePageTitle,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87, // Adjust color
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: FrenchMainDrawer(
        onSelectScreen: _setScreen, // Adjust drawer icon color to match text
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
    );
  }
}
