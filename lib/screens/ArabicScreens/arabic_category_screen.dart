import 'package:muat/models/category.dart';
import 'package:flutter/material.dart';
import 'package:muat/screens/FrenchScreens/documents.dart';

class ArabicCategoryScreen extends StatelessWidget {
  const ArabicCategoryScreen({
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
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => DocumnetsScreen(
                  category: category,
                  subCategory: item.name,
                ),
              ),
            );
          },
          child: Card(
            elevation: 1,
            color: const Color.fromARGB(255, 215, 229, 246),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: ListTile(
                title: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: SizedBox(
                        width: 35, // Fixed width for the count
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFF004595),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
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
                    Expanded(
                      child: Text(
                        formatCategoryName(item.name),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        textDirection:
                            TextDirection.rtl, // Align text to the right
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
