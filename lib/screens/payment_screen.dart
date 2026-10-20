import 'package:flutter/material.dart';
import 'package:health_kiosk/constants/text_strings.dart';
import 'package:health_kiosk/data_maps/language_map.dart';
import 'package:health_kiosk/constants/colors.dart';
import 'package:get/get.dart';
import 'package:health_kiosk/controllers/language_controller.dart';
import 'package:health_kiosk/screens/summary_screen.dart';

import '../commons/primary_button.dart';

class PaymentPage extends StatefulWidget {
  final String patientName;
  final String patientAge;
  final String patientMobile;
  final String symptoms;
  final String department;
  final String doctor;
  final String hospital;

  const PaymentPage({
    super.key,
    required this.patientName,
    required this.patientAge,
    required this.patientMobile,
    required this.symptoms,
    required this.department,
    required this.doctor,
    required this.hospital,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final LanguageController languageController = Get.find<LanguageController>();

  // Variable to store the selected payment method
  String? _selectedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HKColors.primary,
        foregroundColor: HKColors.white,
        title: Obx(() {
          var langMap = appTexts[languageController.selectedLanguage.value] ?? appTexts['english']!;
          return Text(langMap[HKTexts.completeYourPayment] ?? 'Payment');
        }),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text for patient details
            Obx(() {
              var langMap = appTexts[languageController.selectedLanguage.value] ?? appTexts['english']!;
              return Text(
                "${langMap[HKTexts.patientName] ?? 'Patient Name'}: ${widget.patientName}",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              );
            }),

            const SizedBox(height: 10),

            Obx(() {
              var langMap = appTexts[languageController.selectedLanguage.value] ?? appTexts['english']!;
              return Text(
                "${langMap[HKTexts.patientAge] ?? 'Age'}: ${widget.patientAge}",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              );
            }),

            const SizedBox(height: 10),

            Obx(() {
              var langMap = appTexts[languageController.selectedLanguage.value] ?? appTexts['english']!;
              return Text(
                "${langMap[HKTexts.patientMob] ?? 'Mobile'}: ${widget.patientMobile}",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              );
            }),

            const SizedBox(height: 30),

            // Payment details (for example, amount)
            Obx(() {
              var langMap = appTexts[languageController.selectedLanguage.value] ?? appTexts['english']!;
              return Text(
                "${langMap[500] ?? 'Amount to Pay'}: ₹500",
                style: const TextStyle(fontSize: 18),
              );
            }),

            const SizedBox(height: 30),

            // Payment method selection
            Obx(() {
              var langMap = appTexts[languageController.selectedLanguage.value] ?? appTexts['english']!;
              return Text(
                langMap[HKTexts.completeYourPayment] ?? 'Select Payment Method',
                style: const TextStyle(fontSize: 18),
              );
            }),

            const SizedBox(height: 20),

            // Payment options
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                color: HKColors.primary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  ListTile(
                    title: Text("Credit/Debit Card"),
                    leading: Radio<String>(
                      value: 'Debit/Credit Card',
                      groupValue: _selectedPaymentMethod, // Set the group value
                      onChanged: (value) {
                        setState(() {
                          _selectedPaymentMethod = value; // Update the selected payment method
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text("UPI Payment"),
                    leading: Radio<String>(
                      value: 'BHIM UPI',
                      groupValue: _selectedPaymentMethod, // Set the group value
                      onChanged: (value) {
                        setState(() {
                          _selectedPaymentMethod = value; // Update the selected payment method
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text("Cash on Delivery"),
                    leading: Radio<String>(
                      value: 'Cash on Site',
                      groupValue: _selectedPaymentMethod, // Set the group value
                      onChanged: (value) {
                        setState(() {
                          _selectedPaymentMethod = value; // Update the selected payment method
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Pay Now Button
            Obx(() {
              var langMap = appTexts[languageController.selectedLanguage.value] ?? appTexts['english']!;
              return PrimaryButton(
                ontap: () {
                  Get.to(() => SummaryScreen(
                      patientName: widget.patientName,
                      patientAge: widget.patientAge,
                      patientMobile: widget.patientMobile,
                      symptoms: widget.symptoms,
                      department: widget.department,
                      doctor: widget.doctor,
                      hospital: widget.hospital,
                      paymentMethod: _selectedPaymentMethod ?? " ",
                      amount: "Rs 500",
                      transactionNumber: "486521UCDC987",
                  ));
                },
                label: langMap[HKTexts.paynow] ?? 'Pay Now',
              );
            }),
          ],
        ),
      ),
    );
  }
}
