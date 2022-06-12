import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchFieldInAppBar extends StatefulWidget {
  final ValueChanged<String>? onEnter;
  SearchFieldInAppBar({
    Key? key,
    this.hintText,
    required this.onEnter,
  }) : super(key: key);

  final String? hintText;

  @override
  State<SearchFieldInAppBar> createState() => _SearchFieldInAppBarState();
}

class _SearchFieldInAppBarState extends State<SearchFieldInAppBar> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      child: RawKeyboardListener(
        focusNode: FocusNode(onKey: (node, event) {
          if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
            return KeyEventResult.handled;
          }
          return KeyEventResult.ignored;
        }),
        onKey: (e) {
          if (e.isKeyPressed(LogicalKeyboardKey.enter)) {
            setState(() {
              if (widget.onEnter != null) {
                widget.onEnter!(controller.text);
              }
            });
          }
        },
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 14, right: 14),
            hintText: widget.hintText,
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
      ),
    );
  }
}
