import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/components/indicators.dart';
import 'package:fluent_ui/fluent_ui.dart';
// import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.text,
    this.primary = kWhite,
    this.borderColor = kGrey1Color,
    this.borderRadius = 6.0,
    this.hasBorder = false,
    this.textColor,
    this.textStyle,
    this.onPressed,
    this.elevation,
    this.padding,
    this.onPrimary,
    this.isDisabled = false,
    this.isLoading = false,
    // this.permissions,
    this.icon,
  }) : super(key: key);

  final String text;
  final Color? textColor;
  final TextStyle? textStyle;
  final Color primary;
  final Color? onPrimary;
  final bool hasBorder;
  final Color borderColor;
  final double borderRadius;
  final double? elevation;
  final EdgeInsets? padding;
  final bool isLoading;
  final bool isDisabled;
  final Widget? icon;
  final Function()? onPressed;
  // final List<PermissionType>? permissions;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Opacity(
        opacity: isDisabled ? 0.5 : 1,
        child: AbsorbPointer(
          absorbing: isDisabled || isLoading,
          child: FilledButton(
            onPressed: this.onPressed,
            style: ButtonStyle(
              backgroundColor: ButtonState.all(this.primary),
              elevation: ButtonState.all(this.elevation),
              // primary: this.primary,
              // onPrimary: this.onPrimary,
              shape: ButtonState.all(
                RoundedRectangleBorder(
                  side: this.hasBorder
                      ? BorderSide(color: this.borderColor)
                      : BorderSide.none,
                  borderRadius: BorderRadius.circular(this.borderRadius),
                ),
              ),

              padding: ButtonState.all(this.padding),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) icon!,
                SizedBox(width: 8.0),
                if (icon == null)
                  Text(
                    this.text,
                    style: textStyle ??
                        FluentTheme.of(context)
                            .typography
                            .body
                            ?.copyWith(color: textColor),
                  ),
                SizedBox(width: 8.0),
                if (isLoading)
                  ProgressIndicatorSmall(
                    color: textColor ?? kWhite,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FlatBackButton<T> extends StatelessWidget {
  const FlatBackButton({
    Key? key,
    this.result,
  }) : super(key: key);

  final T? result;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(padding: ButtonState.all(EdgeInsets.zero)),
      onPressed: () {
        Navigator.of(context).pop(result);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // AppIcons.svgAsset(
          //   AppIcons.back_android,
          //   color: kGrey1Color,
          //   height: 18,
          //   width: 18,
          // ),
          SizedBox(
            width: 8,
          ),
          Text(
            "Back",
            style: FluentTheme.of(context)
                .typography
                .body
                ?.copyWith(color: kGrey1Color),
          ),
        ],
      ),
    );
  }
}

class TryAgainButton extends StatelessWidget {
  const TryAgainButton({
    Key? key,
    required this.tryAgain,
  }) : super(key: key);

  final VoidCallback tryAgain;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(FluentIcons.error, size: 42, color: Colors.red),
          SizedBox(height: 14),
          Text(
            "Something went wrong",
            style: FluentTheme.of(context).typography.body,
          ),
          SizedBox(height: 8),
          TextButton(
            onPressed: this.tryAgain,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(FluentIcons.refresh),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Try again",
                  style: FluentTheme.of(context).typography.body,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SmallCircleButton extends StatelessWidget {
  const SmallCircleButton({
    Key? key,
    required this.child,
    this.onTap,
  }) : super(key: key);

  final Widget child;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              offset: Offset(0, 4),
              blurRadius: 20,
            ),
          ],
        ),
        child: Center(child: child),
      ),
    );
  }
}
