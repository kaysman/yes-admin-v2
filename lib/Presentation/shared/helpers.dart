import 'package:admin_v2/Presentation/Blocs/snackbar_bloc.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:flutter/material.dart';

Map<String, String> header() {
  return {
    "Content-Type": "application/json",
    "Accept": "*/*",
  };
}

/// -------------
/// [showSnackBar] method shows snackbar.
/// Context should not be null
/// -------------
void showSnackBar(
  BuildContext context,
  Widget child, {
  SnackbarType type = SnackbarType.error,
  Color? backgroundColor,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: backgroundColor != null
          ? backgroundColor
          : type == SnackbarType.error
              ? AppColors.danger
              : AppColors.green2,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
      content: child,
    ),
  );
}

void showAppDialog(
  BuildContext context,
  Widget child,
) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.white,
        child: child,
      );
    },
  );
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
