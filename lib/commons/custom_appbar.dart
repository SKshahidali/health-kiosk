import 'package:flutter/material.dart';
import 'package:health_kiosk/constants/colors.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;
  final VoidCallback? onBackButtonPressed;
  final List<Widget>? actions;

  const CustomAppbar({
    super.key,
    required this.title,
    this.backgroundColor = HKColors.primary, // Use a default color if needed
    this.onBackButtonPressed,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: onBackButtonPressed ?? () => Navigator.pop(context),
      ),
      actions: actions,
      elevation: 4.0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
