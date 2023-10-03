import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.text,
    required this.color,
    required this.onSelectLanguageScreen,
  });

  final Color color;
  final String text;
  final void Function(String identifier) onSelectLanguageScreen;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 380,
      height: 70,
      child: ElevatedButton(
        onPressed: () {
          text == 'نصوص قانونية'
              ? onSelectLanguageScreen('العربية')
              : onSelectLanguageScreen('Français');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 26,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
          ),
        ),
      ),
    );
  }
}
