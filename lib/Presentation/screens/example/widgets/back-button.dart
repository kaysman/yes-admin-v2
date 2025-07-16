import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:admin_v2/Presentation/shared/components/button.dart' as f;

class TableBackButton extends StatelessWidget {
  const TableBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: f.Button(
        text: '',
        primary: kGrey4Color,
        padding: const EdgeInsets.all(8),
        borderColor: Colors.transparent,
        icon: Icon(
          Icons.arrow_back,
          color: kBlack,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
