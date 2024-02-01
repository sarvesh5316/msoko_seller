// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReusableTextFormField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final Color? hintTextColor;

  const ReusableTextFormField({
    super.key,
    this.labelText,
    this.hintText,
    required this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
    this.hintTextColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        hintStyle: GoogleFonts.inter(
          fontSize: 12,
          color: hintTextColor,
          fontWeight: FontWeight.w400,
        ),
        border: OutlineInputBorder(),
        // Use padding property instead of contentPadding
      ),
      validator: validator,
      onChanged: onChanged,
    );
  }
}
