import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      child: TextFormField(
        focusNode: _focusNode,
        controller: controller,
        onFieldSubmitted: (v) => widget.onEnter?.call(v),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 14, right: 14),
          hintText: widget.hintText,
          prefixIcon: Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 8, 8.0),
            child: SvgPicture.asset(
              'assets/search.svg',
              color: _focusNode.hasFocus ? kswPrimaryColor : null,
              width: 18,
              height: 18,
            ),
          ),
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
