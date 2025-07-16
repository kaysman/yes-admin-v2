import 'package:flutter/material.dart';

class GadgetReview extends StatelessWidget {
  final String imgPath;
  final String description;
  const GadgetReview({
    Key? key,
    required this.imgPath,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 7,
              child: Image.asset(
                imgPath,
                fit: BoxFit.scaleDown,
                width: double.infinity,
              ),
            ),
            Spacer(),
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: Text(description),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
