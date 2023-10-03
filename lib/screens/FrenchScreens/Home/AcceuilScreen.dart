import 'package:flutter/material.dart';
import 'package:muat/screens/FrenchScreens/lois_decrets_screen.dart';
import 'package:muat/screens/FrenchScreens/recherche_screen.dart';

import 'package:muat/widgets/FrenchScreenWidgets/french_footer.dart';
import 'package:muat/widgets/FrenchScreenWidgets/icon_button.dart';

class AccueilScreen extends StatefulWidget {
  const AccueilScreen({Key? key}) : super(key: key);

  @override
  State<AccueilScreen> createState() => _AccueilScreenState();
}

class _AccueilScreenState extends State<AccueilScreen> {
  void _setCategoryScreen(String identifier) {
    if (identifier == 'Lois et Directs') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const LoisDirectsScreen(
            title: 'Lois et Directs',
          ),
        ),
      );
    }
    if (identifier == 'Arrêtés et Circulaires') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) =>
              const LoisDirectsScreen(title: 'Arrêtés et Circulaires'),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ButtonwithIcon(
                  text: 'Lois et Directs',
                  icon: const Icon(
                    Icons.library_books,
                    color: Colors.white,
                    size: 25,
                  ),
                  onSelectCategoryScreen: _setCategoryScreen,
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ButtonwithIcon(
                  text: 'Arrêtés et Circulaires',
                  icon: const Icon(
                    Icons.description,
                    color: Colors.white,
                    size: 25,
                  ),
                  onSelectCategoryScreen: _setCategoryScreen,
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ButtonwithIcon(
                  text: 'Recherche',
                  icon: const Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 25,
                  ),
                  onSelectCategoryScreen: _setCategoryScreen,
                ),
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
