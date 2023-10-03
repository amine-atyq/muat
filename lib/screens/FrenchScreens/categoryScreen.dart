import 'package:muat/models/category.dart';
import 'package:flutter/material.dart';
import 'package:muat/screens/FrenchScreens/documents.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({
    super.key,
    required this.categories,
    required this.category,
  });

  final List<Category> categories;
  final String category;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final item = categories[index];
        return Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => DocumnetsScreen(
                        category: category, subCategory: item.name),
                  ),
                );
              },
              child: Card(
                elevation: 1,
                color: const Color.fromARGB(255, 215, 229, 246),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListTile(
                    title: Text(
                      formatCategoryName(item.name),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFF004595),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        item.count.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

String formatCategoryName(String categoryName) {
  if (categoryName == "AttributionsEtOrganisationDuMinistere") {
    return "Attributions Et Organisation Du Ministere";
  } else if (categoryName == "CollectivitesTerritoriales") {
    return "Collectivites Territoriales";
  } else if (categoryName == "ReglementsGenerauxDeConstruction") {
    return "Reglements Generaux De Construction";
  } else if (categoryName == "ServitudesEtEquipementsPublics") {
    return "Servitudes Et Equipements Publics";
  } else {
    return categoryName; // Default case
  }
}
