import 'package:flutter/material.dart';

import 'at-search-input.dart';

class CustomWidgets extends StatefulWidget {
  const CustomWidgets({Key? key}) : super(key: key);

  @override
  State<CustomWidgets> createState() => _CustomWidgetsState();
}

class _CustomWidgetsState extends State<CustomWidgets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AtSearchInput(),
      ),
    );
  }
}
