import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:flutter/material.dart';

class StatusIndicator extends StatelessWidget {
  final bool isBold;
  final bool isInfo;
  final Color color;
  final String? label;
  const StatusIndicator({
    Key? key,
    this.isBold = false,
    this.color = kPrimaryColor,
    this.label,
    this.isInfo = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(radius: 5, backgroundColor: color),
        SizedBox(width: 8),
        Text(
          "$label",
          style: isInfo
              ? Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(fontSize: 20, color: kGrey1Color)
              : Theme.of(context).textTheme.bodyText1,
        )
      ],
    );
  }
}
