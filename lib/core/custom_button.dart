import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String name;
  final VoidCallback? onPressed;
  final MaterialColor buttonColor;

  const CustomButton({super.key,
    required this.name,
    this.onPressed,
    required this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor:Color(0xFF2E3B62),

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0), // Rounded corners
            ),
          ),
          child: Text(
            name,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),

      ),
    );
  }
}