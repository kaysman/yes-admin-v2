import 'package:flutter/material.dart';

class SearchFieldInAppBar extends StatelessWidget {
  SearchFieldInAppBar({
    Key? key,
    this.hintText,
  }) : super(key: key);

  final controller = TextEditingController();
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 14, right: 14),
          hintText: hintText,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              width: 0.0,
              color: Colors.black38,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              width: 0.0,
              color: Colors.black38,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              color: Colors.white24,
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
