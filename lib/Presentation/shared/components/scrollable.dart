import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ScrollableWidget extends StatelessWidget {
  final Widget? child;
  const ScrollableWidget({Key? key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior(),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: child,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
        ),
      ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
