import 'package:flutter/material.dart';

class LabeledInput extends StatelessWidget {
  const LabeledInput({
    Key? key,
    this.controller,
    required this.label,
    this.validator,
    this.editMode = false,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String label;

  final bool editMode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        enabled: editMode,
      ),
    );
  }
}
