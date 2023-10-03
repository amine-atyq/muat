import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({
    super.key,
    required this.onSelectLanguageScreen,
  });

  final void Function(String identifier) onSelectLanguageScreen;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFF004595),
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/maroc.png',
                    width: 60,
                  ),
                  const SizedBox(height: 10),
                  const Text('المملكة المغربية',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromARGB(255, 211, 192, 132),
                        fontSize: 22,
                        height: 0.9,
                      )),
                  const Text('Royaume du maroc',
                      style: TextStyle(
                        color: Color.fromARGB(255, 211, 192, 132),
                        fontSize: 16,
                        height: 0,
                      )),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: const Icon(
              Icons.language,
              size: 26,
              color: Color(0xFF004595),
            ),
            title: Text(
              'العربية',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Color(0xFF004595),
                    fontSize: 24,
                  ),
            ),
            onTap: () {
              onSelectLanguageScreen('العربية');
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.language,
              size: 26,
              color: Color(0xFF004595),
            ),
            title: Text(
              'Français',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Color(0xFF004595),
                    fontSize: 24,
                  ),
            ),
            onTap: () {
              onSelectLanguageScreen('Français');
            },
          ),
        ],
      ),
    );
  }
}
