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
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) =>
                    DocumnetsScreen(category: category, subCategory: item.name),
              ),
            );
          },
          child: Card(
            elevation: 1,
            color: const Color.fromARGB(255, 215, 229, 246),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListTile(
                contentPadding: EdgeInsets.all(0), // Remove default padding
                title: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceBetween, // Aligns content to both ends
                  crossAxisAlignment: CrossAxisAlignment
                      .end, // Aligns content to the end (bottom)
                  children: [
                    Text(
                      item.count.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        formatCategoryName(item.name),
                        textAlign: TextAlign.right, // Align text to the right
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
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
