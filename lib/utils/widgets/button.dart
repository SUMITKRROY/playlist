import 'package:flutter/material.dart';

import '../colors.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue), // Change color here
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(color: CustomColors.white),
      ),
    );

  }
}
