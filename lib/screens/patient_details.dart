import 'package:flutter/material.dart';
import 'package:health_kiosk/screens/patient_symptoms.dart';
import '../../constants/text_strings.dart';
import '../../controllers/language_controller.dart';
import '../commons/primary_button.dart';
import '../commons/text_field.dart';
import '../../../data_maps/language_map.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt; // Import the speech-to-text package

class PatientDetailsScreen extends StatefulWidget {
  PatientDetailsScreen({super.key});

  @override
  _PatientDetailsScreenState createState() => _PatientDetailsScreenState();
}

class _PatientDetailsScreenState extends State<PatientDetailsScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  String patientName = '';
  String patientAge = '';
  String patientPhone = '';

  stt.SpeechToText _speech = stt.SpeechToText(); // Speech-to-text instance
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    nameController.addListener(_updateFormStatus);
    ageController.addListener(_updateFormStatus);
    phoneController.addListener(_updateFormStatus);

    _speech.initialize(); // Initialize the speech-to-text engine
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void _updateFormStatus() {
    setState(() {});
  }

  // Function to handle the start of speech recognition
  void _startListening(TextEditingController controller) async {
    bool available = await _speech.initialize();
    if (available) {
      setState(() {
        _isListening = true;
      });

      _speech.listen(onResult: (result) {
        setState(() {
          controller.text = result.recognizedWords; // Update the controller text immediately with speech
        });
      });
    } else {
      print("Speech recognition not available.");
    }
  }

  void _handleNext() {
    // Save entered data
    patientName = nameController.text;
    patientAge = ageController.text;
    patientPhone = phoneController.text;

    Get.to(() => PatientSymptoms(
      PatientName: patientName,
      PatientAge: patientAge,
      PatientMobileNumber: patientPhone,
    ));
    // call a function to generate the PDF here
    print('Name: $patientName, Age: $patientAge, Phone: $patientPhone');
  }

  @override
  Widget build(BuildContext context) {
    final languageController = Get.find<LanguageController>();
    final texts = appTexts[languageController.selectedLanguage.value]!;

    bool isFormFilled = nameController.text.isNotEmpty &&
        ageController.text.isNotEmpty &&
        phoneController.text.isNotEmpty;

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              texts[HKTexts.patientDetails] ?? 'Enter your Details',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 30),
            CustomTextField(
              labelKey: HKTexts.enterFullName,
              keyboardType: TextInputType.name,
              controller: nameController,
              suffixIcon: IconButton(
                icon: Icon(Icons.mic),
                onPressed: () => _startListening(nameController), // Start voice input for name
              ),
            ),
            CustomTextField(
              labelKey: HKTexts.enterAge,
              keyboardType: TextInputType.number,
              controller: ageController,
              suffixIcon: IconButton(
                icon: Icon(Icons.mic),
                onPressed: () => _startListening(ageController), // Start voice input for age
              ),
            ),
            CustomTextField(
              labelKey: HKTexts.enterPhoneNumber,
              keyboardType: TextInputType.phone,
              controller: phoneController,
              suffixIcon: IconButton(
                icon: Icon(Icons.mic),
                onPressed: () => _startListening(phoneController), // Start voice input for phone
              ),
            ),
            const SizedBox(height: 60),
            PrimaryButton(
              ontap: isFormFilled ? _handleNext : null,
              label: texts[HKTexts.next] ?? 'Next',
              isEnabled: isFormFilled, // Pass the button state
            ),
          ],
        ),
      ),
    );
  }
}
