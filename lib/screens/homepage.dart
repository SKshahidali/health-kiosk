import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_kiosk/controllers/language_controller.dart';
import 'package:health_kiosk/screens/patient_details.dart';
import '../commons/primary_button.dart';
import '../constants/text_strings.dart';
import '../data_maps/language_map.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final languageController = Get.find<LanguageController>();
    final texts = appTexts[languageController.selectedLanguage.value]!;

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PrimaryButton(ontap: () {
              Get.to(() => PatientDetailsScreen());
            }, label: texts[HKTexts.newAppointment]!),
            const SizedBox(height: 32,),
            PrimaryButton(ontap: () {}, label: texts[HKTexts.myAppointments]!)
          ],
        ),
      ),
    );
  }
}