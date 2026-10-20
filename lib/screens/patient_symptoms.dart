import 'package:flutter/material.dart';
import 'package:health_kiosk/constants/text_strings.dart';
import 'package:health_kiosk/data_maps/language_map.dart';
import 'package:health_kiosk/screens/payment_screen.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:health_kiosk/constants/colors.dart';
import 'package:get/get.dart';
import 'package:health_kiosk/controllers/language_controller.dart';
import 'package:health_kiosk/data_maps/symptoms_mapping.dart';

import '../commons/custom_appbar.dart';
import '../commons/primary_button.dart';

class PatientSymptoms extends StatefulWidget {
  final String PatientName;
  final String PatientAge;
  final String PatientMobileNumber;

  const PatientSymptoms({
    super.key,
    required this.PatientName,
    required this.PatientAge,
    required this.PatientMobileNumber,
  });

  @override
  State<PatientSymptoms> createState() => _PatientSymptomsState();
}

class _PatientSymptomsState extends State<PatientSymptoms> {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _wordsSpoken = "";
  String _department = "General Consultation";
  List<String> _doctorNames = [];
  String? _selectedDoctor;

  final LanguageController languageController = Get.find<LanguageController>();

  @override
  void initState() {
    super.initState();
    initSpeech();
  }

  void initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(result) {
    setState(() {
      _wordsSpoken = result.recognizedWords;
      _mapSymptomsToDepartment();
    });
  }

  void _mapSymptomsToDepartment() {
    _department = "General Consultation";
    _doctorNames = [];
    _selectedDoctor = null;
    for (var symptom in symptomMapping.keys) {
      if (_wordsSpoken.toLowerCase().contains(symptom)) {
        _department = symptomMapping[symptom]!["department"]!;
        _doctorNames = List<String>.from(symptomMapping[symptom]!["doctors"]!);
        _selectedDoctor = _doctorNames.isNotEmpty ? _doctorNames[0] : null;
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: HKTexts.patientDetails,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() {
                var langMap = appTexts[languageController.selectedLanguage.value] ?? appTexts['english']!;
                return Container(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    langMap[HKTexts.describeYourSymptoms] ?? 'Describe your symptoms',
                    style: const TextStyle(fontSize: 22.0, color: Colors.black),
                  ),
                );
              }),

              const SizedBox(height: 10),

              Container(
                padding: const EdgeInsets.all(16),
                width: MediaQuery.of(context).size.width * 0.75,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(12)
                ),
                child: Text(
                  _wordsSpoken.isNotEmpty ? _wordsSpoken : HKTexts.useRecordButtonToSpeak,
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
              const SizedBox(height: 20),

              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: HKColors.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: IconButton(
                  icon: Icon(
                    _speechToText.isNotListening ? Icons.mic_off : Icons.mic,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: _speechToText.isListening ? _stopListening : _startListening,
                ),
              ),
              const SizedBox(height: 30),

              if (_department.isNotEmpty) ...[
                const SizedBox(height: 20),

                Obx(() {
                  var langMap = appTexts[languageController.selectedLanguage.value] ?? appTexts['english']!;
                  return Container(
                    padding: const EdgeInsets.all(6),
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      color: HKColors.grey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: symptomMapping.values.any((e) => e["department"] == _department) ? _department : null,
                      hint: Text(langMap[HKTexts.departmentName] ?? 'Select Department'),
                      items: symptomMapping.keys.map((symptom) {
                        String departmentName = symptomMapping[symptom]!["department"]!;
                        return DropdownMenuItem<String>(
                          value: departmentName,
                          child: Text(departmentName),
                        );
                      }).toList(),
                      onChanged: (newDepartment) {
                        setState(() {
                          _department = newDepartment ?? _department;
                          _doctorNames = List<String>.from(
                              symptomMapping.entries.firstWhere((entry) => entry.value["department"] == newDepartment)
                                  .value["doctors"]!);
                          _selectedDoctor = _doctorNames.isNotEmpty ? _doctorNames[0] : null;
                        });
                      },
                    ),
                  );
                }),

                const SizedBox(height: 10),

                if (_doctorNames.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(6),
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      color: HKColors.grey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: _selectedDoctor,
                      hint: Obx(() {
                        var langMap = appTexts[languageController.selectedLanguage.value] ?? appTexts['english']!;
                        return Text(langMap[HKTexts.doctorName] ?? 'Select Doctor');
                      }),
                      items: _doctorNames.map((doctor) {
                        return DropdownMenuItem<String>(
                          value: doctor,
                          child: Text(doctor),
                        );
                      }).toList(),
                      onChanged: (newDoctor) {
                        setState(() {
                          _selectedDoctor = newDoctor;
                        });
                      },
                    ),
                  ),

                if (_department.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Obx(() {
                      var langMap = appTexts[languageController.selectedLanguage.value] ?? appTexts['english']!;
                      return Text(
                        "${langMap[HKTexts.departmentName] ?? 'Department Name'}: $_department",
                        style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                      );
                    }),
                  ),

                if (_selectedDoctor != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Obx(() {
                      var langMap = appTexts[languageController.selectedLanguage.value] ?? appTexts['english']!;
                      return Text(
                        "${langMap[HKTexts.doctorName] ?? 'Doctor Name'}: $_selectedDoctor",
                        style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                      );
                    }),
                  ),

                const SizedBox(height: 30),

                Obx(() {
                  var langMap = appTexts[languageController.selectedLanguage.value] ?? appTexts['english']!;
                  return PrimaryButton(
                    ontap: () {
                      Get.to(() => PaymentPage(
                        patientName: widget.PatientName,
                        patientAge: widget.PatientAge,
                        patientMobile: widget.PatientMobileNumber,
                        symptoms: _wordsSpoken,
                        department: _department,
                        doctor: _selectedDoctor ?? "General Consultation",
                        hospital: 'AIIMS Bhubaneswar',
                      ));
                    },
                    label: langMap[HKTexts.next] ?? 'Next',
                  );
                })
              ]
            ],
          ),
        ),
      ),
    );
  }
}
