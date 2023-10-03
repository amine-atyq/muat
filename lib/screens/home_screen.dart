import 'package:flutter/material.dart';
import 'package:muat/screens/ArabicScreens/arabic_home_screen.dart';
import 'package:muat/screens/FrenchScreens/french_home_screen.dart';
import 'package:muat/widgets/HomeScreenWidgets/button.dart';
import 'package:muat/widgets/HomeScreenWidgets/clip_path.dart';
import 'package:muat/widgets/HomeScreenWidgets/footer.dart';
import 'package:muat/widgets/main_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _setLanguageScreen(String identifier) {
    Navigator.of(context).pop();
    if (identifier == 'العربية') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const ArabicHomeScreen(),
        ),
      );
    }
    if (identifier == 'Français') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const FrenchHomeScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFD3C084),
      ),
      drawer: MainDrawer(
        onSelectLanguageScreen: _setLanguageScreen,
      ),
      body: Stack(
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
          Column(
            children: [
              const MyCliipPath(),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30), // Add padding here
                        child: ButtonWidget(
                          text: 'نصوص قانونية',
                          color: const Color(0xFF002D5F),
                          onSelectLanguageScreen: _setLanguageScreen,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30), // Add padding here
                        child: ButtonWidget(
                          text: 'Textes juridiques',
                          color: const Color(0xFF0D6938),
                          onSelectLanguageScreen: _setLanguageScreen,
                        ),
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
              const FooterWidget(),
            ],
          ),
        ],
      ),
    );
  }
}
