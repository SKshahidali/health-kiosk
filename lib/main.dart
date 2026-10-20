import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_kiosk/screens/language_screen.dart';
import 'package:health_kiosk/controllers/language_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Initialize LanguageController with Get.put
    Get.put(LanguageController());

    return const GetMaterialApp(
      title: 'Health Kiosk',
      home: LanguageSelectionScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
