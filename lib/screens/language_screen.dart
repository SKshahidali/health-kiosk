import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_kiosk/controllers/language_controller.dart';
import '../commons/primary_button.dart';
import 'homepage.dart';

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the instance of LanguageController
    final languageController = Get.find<LanguageController>();

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Select your Language", style: TextStyle(fontSize: 20)),
          const SizedBox(height: 50),
          PrimaryButton(
            ontap: () {
              languageController.setLanguage('english');
              Get.to(() => Homepage());
            },
            label: 'English',
          ),
          const SizedBox(height: 30),
          PrimaryButton(
            ontap: () {
              languageController.setLanguage('hindi');
              Get.to(() => Homepage());
            },
            label: 'हिंदी',
          ),
          const SizedBox(height: 30),
          PrimaryButton(
            ontap: () {
              languageController.setLanguage('odia');
              Get.to(() => Homepage());
            },
            label: 'ଓଡିଆ',
          ),
        ],
      ),
    );
  }
}
