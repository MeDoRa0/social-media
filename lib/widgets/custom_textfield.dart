import 'package:flutter/material.dart';
import 'package:social_media/colors.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({
    super.key,
    this.controller,
    this.hintText = '',
    this.icon,
    this.labelText = '',
    this.keyboardType = TextInputType.text,
  });

  final TextEditingController? controller;
  final String hintText;
  final IconData? icon;
  final String labelText;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: kPrimaryColor),
        fillColor: kPrimaryColor.withOpacity(0.09),
        filled: true,
        prefixIcon: Icon(icon),
        hintText: hintText,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(16),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
