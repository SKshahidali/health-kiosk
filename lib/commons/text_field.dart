import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_kiosk/controllers/language_controller.dart';

import '../data_maps/language_map.dart';

class CustomTextField extends StatelessWidget {
  final String labelKey;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final Widget? suffixIcon;

  CustomTextField({
    required this.labelKey,
    required this.keyboardType,
    required this.controller,
    this.suffixIcon, // Initialize suffixIcon as null by default
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Access LanguageController instance to get the selected language
    final languageController = Get.find<LanguageController>();
    final selectedLanguage = languageController.selectedLanguage.value;
    final labelText = appTexts[selectedLanguage]![labelKey] ?? 'Label';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          suffixIcon: suffixIcon, // Add suffixIcon here
        ),
      ),
    );
  }
}
