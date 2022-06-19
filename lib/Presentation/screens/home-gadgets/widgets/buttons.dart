import 'package:admin_v2/Presentation/shared/components/button.dart';
import 'package:admin_v2/Presentation/shared/components/input_fields.dart';
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
        OutlinedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            "Cancel",
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: Theme.of(context).primaryColor,
                ),
          ),
        ),
        SizedBox(width: 16),
        Button(
          isLoading: widget.isLoading ?? false,
          text: "Save",
          onPressed: () {
            // if (widget.formKey.currentState?.validate() == true) {
            widget.onPressed.call();
            // }
          },
        ),
      ],
    );
  }
}

class Type3 extends StatelessWidget {
  const Type3({
    Key? key,
    required this.mainWidth,
  }) : super(key: key);

  final double mainWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: UniqueKey(),
      width: mainWidth / 2,
      color: Colors.pink,
    );
  }
}

class Type2 extends StatelessWidget {
  const Type2({
    Key? key,
    required this.mainWidth,
  }) : super(key: key);

  final double mainWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: mainWidth / 2,
      key: UniqueKey(),
      color: Colors.amber,
    );
  }
}

class Type1 extends StatelessWidget {
  Type1({
    Key? key,
    required this.mainWidth,
  }) : super(key: key);

  final double mainWidth;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        key: UniqueKey(),
        width: mainWidth / 2,
        // color: kPrimaryColor,
        child: SingleChildScrollView(
          child: SizedBox(
            height: 200,
            child: Column(
              children: [
                LabeledInput(
                    editMode: true, controller: controller, label: 'Text'),
                Spacer(),
                LabeledInput(
                    editMode: true, controller: controller, label: 'Surat'),
                Spacer(),
                LabeledInput(
                    editMode: true, controller: controller, label: 'Surat'),
                Spacer(),
                LabeledInput(
                    editMode: true, controller: controller, label: 'Surat'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
