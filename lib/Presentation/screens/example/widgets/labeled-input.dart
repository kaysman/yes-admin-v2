import 'package:flutter/material.dart';

class MaterialLabeledInput extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final bool isEditMode;
  final bool isTapped;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;

  const MaterialLabeledInput({
    Key? key,
    this.controller,
    this.label,
    this.isEditMode = false,
    this.isTapped = false,
    this.validator,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            label!,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          validator: validator,
          onChanged: onChanged,
          enabled: isEditMode,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            // You can add more decoration customization here
          ),
        ),
      ],
    );
  }
}
