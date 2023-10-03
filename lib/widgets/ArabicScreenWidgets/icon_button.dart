import 'package:flutter/material.dart';

class ButtonwithIcon extends StatelessWidget {
  const ButtonwithIcon({
    super.key,
    required this.text,
    required this.icon,
    required this.onSelectCategoryScreen,
  });

  final String text;
  final Icon icon;
  final void Function(String identifier) onSelectCategoryScreen;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 380,
      child: ElevatedButton(
        onPressed: () {
          onSelectCategoryScreen(text);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF004595),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // Set border radius
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: 5), // Add spacing between icon and text
            Text(
              text,
              style: const TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
