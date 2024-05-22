import 'package:flutter/material.dart';
import 'package:social_media/colors.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield(
      {super.key, required this.controller, required this.hintText,required this.icon});

  final TextEditingController controller;
  final String hintText;
 final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      controller: controller,
      decoration: InputDecoration(
        fillColor: kWhiteColor,
        filled: true,
        prefixIcon:  Icon(icon),
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
