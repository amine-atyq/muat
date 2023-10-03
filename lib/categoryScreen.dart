import 'package:muat/models/category.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({
    super.key,
    required this.categories,
  });

  final List<Category> categories;

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
                /*
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const DocumnetsScreen(),
                  ),
                );*/
              },
              child: Card(
                elevation: 1,
                color: const Color.fromARGB(255, 173, 204, 240),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListTile(
                    title: Text(
                      item.name,
                      style: const TextStyle(
                        fontSize: 15,
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
