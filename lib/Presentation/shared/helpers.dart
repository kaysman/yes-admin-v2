import 'package:admin_v2/Presentation/screens/home-gadgets/gadget-update.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:fluent_ui/fluent_ui.dart' as f;
import 'package:flutter/material.dart';

Map<String, String> header() {
  return {
    "Content-Type": "application/json",
    "Accept": "*/*",
  };
}

final OutlineInputBorder kErrorInputBorder = OutlineInputBorder(
  borderSide: BorderSide(color: Colors.red),
  borderRadius: BorderRadius.circular(8),
);
final OutlineInputBorder kFocusedInputBorder = OutlineInputBorder(
  borderSide: BorderSide(color: kswPrimaryColor),
  borderRadius: BorderRadius.circular(8),
);
final OutlineInputBorder kEnabledInputBorder = OutlineInputBorder(
  borderSide: BorderSide(color: kGrey3Color),
  borderRadius: BorderRadius.circular(8),
);
final OutlineInputBorder kDisabledInputBorder = OutlineInputBorder(
  borderSide: BorderSide(color: kGrey4Color),
  borderRadius: BorderRadius.circular(8),
);
final BoxDecoration kDropDownBorder = BoxDecoration(
  border: Border.all(color: Colors.black45),
  borderRadius: BorderRadius.circular(8),
);

final RoundedRectangleBorder kCardBorder = RoundedRectangleBorder(
  side: BorderSide(color: kGrey3Color),
  borderRadius: BorderRadius.circular(8),
);

final DropDownDecoratorProps kDropDownDecoratorProps = DropDownDecoratorProps(
  dropdownSearchDecoration: InputDecoration(
    enabledBorder: kEnabledInputBorder,
    focusedBorder: kFocusedInputBorder,
    errorBorder: kErrorInputBorder,
    disabledBorder: kDisabledInputBorder,
  ),
);

final BoxShadow shadow = BoxShadow(
  blurRadius: 10,
  color: Colors.black12,
  offset: Offset(1, -1),
  spreadRadius: 1,
);

/// -------------
/// [showSnackBar] method shows snackbar.
/// Context should not be null
/// -------------
enum SnackbarType { success, error }

void showSnackBar(
  BuildContext context,
  Widget child, {
  SnackbarType type = SnackbarType.error,
  Color? backgroundColor,
  double? width = 230,
}) {
  f.showSnackbar(
    context,
    SnackBar(
      backgroundColor: backgroundColor != null
          ? backgroundColor
          : type == SnackbarType.error
              ? AppColors.danger
              : AppColors.green2,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
      content: child,
      width: width,
    ),
  );
}

showAppDialog(
  BuildContext context,
  Widget child,
) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.white,
        child: child,
      );
    },
  );
}

Future<T?> showFluentAppDialog<T>(
  BuildContext context, {
  Widget? title,
  Widget? content,
  List<Widget>? actions,
}) async {
  return await showDialog<T>(
    context: context,
    // barrierDismissible: true,
    builder: (context) {
      return f.ContentDialog(
        constraints: BoxConstraints(maxWidth: 800),
        title: title,
        content: content,
        actions: actions,
        // f.Button(
        //   child: Text('Cancel'),
        //   onPressed: () => Navigator.of(context).pop(),
        // ),
        // f.FilledButton(
        //   child: Text('Go'),
        //   onPressed: () => Navigator.of(context).pop(),
        // ),
      );
    },
  );
}

T? checkIfChangedAndReturn<T>(T? oldValue, T? newValue) {
  return (oldValue != newValue && newValue != '-' && newValue != '')
      ? newValue
      : null;
}

/// ---------
/// [hideKeyboard] hides keyboard in provided context
/// ---------
void hideKeyboard({BuildContext? context}) {
  if (context == null) {
    FocusManager.instance.primaryFocus?.unfocus();
  } else {
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}

/// ------
/// [customLogger]
/// ------
log<T>(T value) {
  print('-- -- -- -- --');
  print(value);
  print('--  --  --  --  --');
}
