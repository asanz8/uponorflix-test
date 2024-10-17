import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uponorflix/generated/l10n.dart';

class CustomNumberField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final bool isRequired;
  final int? maxLength;

  const CustomNumberField({
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
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        keyboardType: TextInputType.number,
        maxLength: maxLength,
        cursorColor: Colors.blueAccent,
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
          if (isRequired) {
            if (value == null || value.isEmpty) {
              return S.of(context).requiredField(label);
            } else if (int.tryParse(value) == null) {
              return S.of(context).enterValidNumber;
            }
          }

          return null;
        },
      ),
    );
  }
}
