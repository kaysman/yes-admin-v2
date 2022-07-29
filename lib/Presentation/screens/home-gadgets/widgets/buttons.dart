import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/components/button.dart';
import 'package:flutter/material.dart';

class ButtonsForGadgetCreation extends StatefulWidget {
  const ButtonsForGadgetCreation({
    Key? key,
    this.formKey,
    this.isLoading = false,
    required this.onPressed,
  }) : super(key: key);

  final GlobalKey<FormState>? formKey;
  final bool? isLoading;
  final VoidCallback onPressed;

  @override
  State<ButtonsForGadgetCreation> createState() =>
      _ButtonsForGadgetCreationState();
}

class _ButtonsForGadgetCreationState extends State<ButtonsForGadgetCreation> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Button(
          text: 'Cancel',
          hasBorder: true,
          borderColor: kGrey5Color,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        SizedBox(width: 16),
        Button(
          isLoading: widget.isLoading ?? false,
          text: "Save",
          primary: kswPrimaryColor,
          textColor: kWhite,
          onPressed: () {
            if (widget.formKey!.currentState!.validate()) {
              widget.onPressed.call();
            }
          },
        ),
      ],
    );
  }
}
