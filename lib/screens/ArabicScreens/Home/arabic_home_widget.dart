import 'package:flutter/material.dart';
import 'package:muat/screens/ArabicScreens/arabic_arretes_circulaires_screen.dart';
import 'package:muat/screens/ArabicScreens/arabic_lois_directs_screen.dart';
import 'package:muat/screens/ArabicScreens/arabic_recherche_screen.dart';

import 'package:muat/widgets/FrenchScreenWidgets/french_footer.dart';
import 'package:muat/widgets/ArabicScreenWidgets/icon_button.dart';

class ArabicHomeScreenWidget extends StatefulWidget {
  const ArabicHomeScreenWidget({Key? key}) : super(key: key);

  @override
  State<ArabicHomeScreenWidget> createState() => _ArabicHomeScreenWidgetState();
}

class _ArabicHomeScreenWidgetState extends State<ArabicHomeScreenWidget> {
  void _setCategoryScreen(String identifier) {
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
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: 0.1,
          child: Image.asset(
            'assets/images/pattern.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ButtonwithIcon(
                text: 'قوانين ومراسيم',
                icon: const Icon(
                  Icons.library_books,
                  color: Colors.white,
                  size: 25,
                ),
                onSelectCategoryScreen: _setCategoryScreen,
              ),
              const SizedBox(height: 8),
              ButtonwithIcon(
                text: 'قرارات ودوريات',
                icon: const Icon(
                  Icons.description,
                  color: Colors.white,
                  size: 25,
                ),
                onSelectCategoryScreen: _setCategoryScreen,
              ),
              const SizedBox(height: 8),
              ButtonwithIcon(
                text: 'بحث',
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 25,
                ),
                onSelectCategoryScreen: _setCategoryScreen,
              ),
              const SizedBox(height: 220),
              const FrenchFooterWidget(),
            ],
          ),
        ),
      ],
    );
  }
}
