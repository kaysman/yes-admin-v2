import 'package:flutter/material.dart';

import 'indicators.dart';

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.text,
    this.textStyle,
    this.onPressed,
    this.isDisabled = false,
    this.isLoading = false,
    this.icon,
  }) : super(key: key);

  final String text;
  final TextStyle? textStyle;
  final bool isLoading;
  final bool isDisabled;
  final Widget? icon;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isDisabled ? 0.5 : 1,
      child: AbsorbPointer(
        absorbing: isDisabled || isLoading,
        child: ElevatedButton(
          onPressed: this.onPressed,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) icon!,
              SizedBox(width: 12),
              Text(
                this.text,
                style: textStyle ??
                    Theme.of(context)
                        .textTheme
                        .bodyText2
                        ?.copyWith(color: Colors.white),
              ),
              SizedBox(width: 12),
              if (isLoading) ProgressIndicatorSmall(color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
