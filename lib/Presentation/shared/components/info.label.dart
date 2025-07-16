import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

enum InfoType { text, date, dropdown }

class InfoWithLabel<T> extends StatelessWidget {
  final String label;
  final String hintText;
  final bool editMode;

  final bool? isLoading;

  // use this data if infoType is dropdown
  final T? value;
  final ValueChanged<T?>? onValueChanged;
  final FormFieldValidator<T?>? validator;
  final List<DropdownMenuItem<T>>? items;

  const InfoWithLabel({
    Key? key,
    this.validator,
    this.isLoading = false,
    required this.label,
    required this.editMode,
    this.value,
    this.items,
    this.onValueChanged,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    assert(onValueChanged != null || items != null);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: kGrey1Color,
                  ),
            ),
            if (isLoading == true) ...[
              SizedBox(
                width: 5,
              ),
              SizedBox(
                width: 15,
                height: 15,
                child: CircularProgressIndicator(
                  color: kPrimaryColor,
                  strokeWidth: 1,
                ),
              ),
            ],
          ],
        ),
        if (isLoading == false) ...[
          SizedBox(height: 5),
          dropdownInput(context)
        ],
      ],
    );
  }

  placeholder() {
    return Container(
      padding: const EdgeInsets.only(
        left: 0, //12,
        right: 8,
        bottom: 12,
      ),
      child: Text("-"),
    );
  }

  dropdownInput(BuildContext context) {
    if (onValueChanged == null || items == null) return placeholder();
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField2<T>(
        key: UniqueKey(),
        validator: this.validator,
        isExpanded: true,
        isDense: true,
        value: this.value,
        onChanged: this.editMode ? this.onValueChanged : null,
        style: Theme.of(context).textTheme.bodyText1,
        items: this.items!,
        decoration: InputDecoration(
          enabledBorder: kEnabledInputBorder,
          focusedBorder: kFocusedInputBorder,
          errorBorder: kErrorInputBorder,
        ),
      ),
    );
  }
}
