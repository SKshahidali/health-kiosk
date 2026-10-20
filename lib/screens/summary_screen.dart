import 'dart:io';
import 'package:flutter/material.dart';
import 'package:health_kiosk/constants/colors.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import '../commons/custom_appbar.dart';
import '../commons/primary_button.dart';

class SummaryScreen extends StatelessWidget {
  final String patientName;
  final String patientAge;
  final String patientMobile;
  final String symptoms;
  final String department;
  final String doctor;
  final String hospital;
  final String paymentMethod;
  final String amount;
  final String transactionNumber;

  // Constructor to receive details from the previous screen
  const SummaryScreen({
    Key? key,
    required this.patientName,
    required this.patientAge,
    required this.patientMobile,
    required this.symptoms,
    required this.department,
    required this.doctor,
    required this.hospital,
    required this.paymentMethod,
    required this.amount,
    required this.transactionNumber,
  }) : super(key: key);

  // Method to generate PDF and save it to a file
  Future<void> _generatePDF() async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [

              // Header of the PDF
              pw.Container(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.Text(
                      "Appointment Slip",
                      style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
                      textAlign: pw.TextAlign.center,
                    ),
                    pw.Divider(thickness: 2),
                  ],
                ),
              ),
              pw.SizedBox(height: 30),

              // Patient Details
              pw.Container(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Center(
                      child: pw.Text("Patient Details", style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
                    ),
                    pw.SizedBox(height: 30),
                    pw.Text("Name of the Patient: $patientName", style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
                    pw.Text("Age of the Patient: $patientAge", style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
                    pw.Text("Mobile Number: $patientMobile", style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
                  ],
                ),
              ),
              pw.SizedBox(height: 20),

              // Symptoms as Described by the Patient Through Voice
              pw.Center(
                child: pw.Text("Symptoms", style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
              ),
              pw.SizedBox(height: 10),
              pw.Text(symptoms),
              pw.SizedBox(height: 40),

              // Appointment Details
              pw.Container(
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black, style: pw.BorderStyle.dotted),
                ),
                padding: const pw.EdgeInsets.all(10),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Center(
                      child: pw.Text("Appointment Details", style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
                    ),
                    pw.SizedBox(height: 10),
                    pw.Text("Doctor: $doctor"),
                    pw.Text("Department: $department"),
                    pw.Text("Hospital: $hospital"),
                  ],
                ),
              ),

               pw.SizedBox(height: 30),
              // Payment Details
              pw.Container(
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black, style: pw.BorderStyle.dotted),
                ),
                padding: const pw.EdgeInsets.all(10),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Center(
                      child: pw.Text("Appointment Details", style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
                    ),
                    pw.SizedBox(height: 10),
                    pw.Text("Payment Mode: $paymentMethod"),
                    pw.Text("Amount: $amount"),
                    pw.Text("Transaction ID: $transactionNumber"),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );

    // Save the PDF to a file
    //final output = await getTemporaryDirectory();
    //final file = File('${output.path}/patient_summary.pdf');
    //await file.writeAsBytes(await pdf.save());

    // Debug: Print the file path
    //print("PDF saved to: ${file.path}");

    // Optionally, share or open the saved PDF
    await Printing.sharePdf(bytes: await pdf.save(), filename: 'Appointment_Slip.pdf');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Summary Slip',),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              const Text(
                "Patient Summary",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
          
              // Patient Details
              const Text(
                "Patient Details:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "Name: $patientName\nAge: $patientAge\nMobile: $patientMobile",
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 20),
          
              // Symptoms
              const Text(
                "Symptoms:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  symptoms,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 20),
          
              // Appointment Details
              const Text(
                "Appointment Details:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "Doctor: $doctor\nDepartment: $department\nHospital: $hospital",
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 32,),
              // Payment Details
              const Text(
                "Payment Details:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "Payment Method: $paymentMethod\nAmount: $amount\nTransaction ID: $transactionNumber",
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 30,),
          
              // Print Button
              PrimaryButton(
                ontap: () {
                  _generatePDF();
                },
                label: "Download Slip",
              ),
            ],
          ),
        ),
      ),
    );
  }
}