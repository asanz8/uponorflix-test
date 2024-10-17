import 'package:flutter/material.dart';
import 'package:uponorflix/generated/l10n.dart';
import 'package:uponorflix/shared/util/date_util.dart';

class CustomDatePicker extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final bool isRequired;

  const CustomDatePicker({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.isRequired = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextFormField(
        readOnly: true,
        onTap: () async {
          final dateTime = await showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              lastDate: DateTime.now());

          if (dateTime != null) {
            controller.text = DateUtil.getFormattedDate(dateTime);
          }
        },
        controller: controller,
        decoration: InputDecoration(
          labelText: isRequired ? '$label *' : label,
          floatingLabelStyle: const TextStyle(color: Colors.blueAccent),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
          border: const OutlineInputBorder(),
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
