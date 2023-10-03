import 'package:flutter/material.dart';

class FrenchMainDrawer extends StatelessWidget {
  const FrenchMainDrawer({
    super.key,
    required this.onSelectScreen,
  });

  final void Function(String identifier) onSelectScreen;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            //padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Color(0xFF004595),
            ),
            child: Container(
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
              Icons.home,
              size: 26,
              color: Color(0xFF004595),
            ),
            title: Text(
              'Accueil',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Color(0xFF004595),
                    fontSize: 24,
                  ),
            ),
            onTap: () {
              onSelectScreen('Accueil');
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.library_books,
              size: 26,
              color: Color(0xFF004595),
            ),
            title: Text(
              'Lois et Directs',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Color(0xFF004595),
                    fontSize: 24,
                  ),
            ),
            onTap: () {
              onSelectScreen('Lois et Directs');
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.description,
              size: 26,
              color: Color(0xFF004595),
            ),
            title: Text(
              'Arrêtés et Circulaires',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: const Color(0xFF004595),
                    fontSize: 24,
                  ),
            ),
            onTap: () {
              onSelectScreen('Arrêtés et Circulaires');
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.search,
              size: 26,
              color: Color(0xFF004595),
            ),
            title: Text(
              'Recherche',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: const Color(0xFF004595),
                    fontSize: 24,
                  ),
            ),
            onTap: () {
              onSelectScreen('Recherche');
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.perm_contact_cal,
              size: 26,
              color: Color(0xFF004595),
            ),
            title: Text(
              'Contact',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: const Color(0xFF004595),
                    fontSize: 24,
                  ),
            ),
            onTap: () {
              onSelectScreen('Contact');
            },
          ),
        ],
      ),
    );
  }
}
