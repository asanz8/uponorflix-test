import 'package:flutter/material.dart';
import 'package:uponorflix/generated/l10n.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final bool isRequired;
  final int? maxLength;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.maxLength,
    this.isRequired = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextFormField(
        controller: controller,
        cursorColor: Colors.blueAccent,
        maxLength: maxLength,
        decoration: InputDecoration(
          labelText: isRequired ? '$label *' : label,
          floatingLabelStyle: const TextStyle(color: Colors.blueAccent),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
          border: const OutlineInputBorder(),
          focusColor: Colors.blueAccent,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
          ),
        ),
        validator: (value) {
          if (isRequired && (value == null || value.isEmpty)) {
            return S.of(context).requiredField(label);
          }
          return null;
        },
      ),
    );
  }
}
