// import 'package:flutter/material.dart';

import 'package:fluent_ui/fluent_ui.dart';

class ProgressIndicatorSmall extends StatelessWidget {
  final Color color;

  const ProgressIndicatorSmall({
    Key? key,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 15,
        width: 15,
        child: ProgressRing(
          // color: color,
          strokeWidth: 2,
        ),
      ),
    );
  }
}
