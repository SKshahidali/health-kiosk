import 'package:flutter/material.dart';
import 'package:health_kiosk/constants/colors.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback? ontap;
  final String label;
  final bool isEnabled;

  const PrimaryButton({
    Key? key,
    required this.ontap,
    required this.label,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled ? ontap : null,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
          width: MediaQuery.of(context).size.width * 0.75,
          decoration: BoxDecoration(
            color: isEnabled ? HKColors.primary : Colors.grey, // Set color based on enabled state
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
