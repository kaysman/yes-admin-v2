import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'package:flutter/material.dart';

class LabeledInput extends StatelessWidget {
  const LabeledInput({
    Key? key,
    this.controller,
    this.label,
    this.validator,
    this.editMode = false,
    this.hintText,
    this.onChanged,
    this.initialValue,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? label;
  final String? hintText;
  final ValueChanged<String?>? onChanged;
  final String? initialValue;
  final bool editMode;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hintText ?? '-',
          style: Theme.of(context).textTheme.headline5!.copyWith(
                fontWeight: FontWeight.w500,
                color: kGrey1Color,
              ),
        ),
        SizedBox(height: 5),
        TextFormField(
          initialValue: this.initialValue,
          controller: controller,
          validator: validator,
          onChanged: this.onChanged,
          decoration: InputDecoration(
            // hintText: hintText,
            // hintStyle: Theme.of(context)
            //     .textTheme
            //     .subtitle1
            //     ?.copyWith(color: kGrey2Color),
            // labelText: label,
            labelStyle: Theme.of(context).textTheme.subtitle1,
            enabled: editMode,
            disabledBorder: kDisabledInputBorder,
            focusedErrorBorder: kErrorInputBorder,
            errorBorder: kErrorInputBorder,
            focusedBorder: kFocusedInputBorder,
            enabledBorder: kEnabledInputBorder,
          ),
        ),
      ],
    );
  }
}
