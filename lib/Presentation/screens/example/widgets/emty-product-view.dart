import 'package:flutter/material.dart';

class EmptyProductView extends StatelessWidget {
  const EmptyProductView({
    Key? key,
    required this.emptyText,
    this.isGadget,
  }) : super(key: key);
  final String emptyText;
  final bool? isGadget;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .8,
      child: Center(
        child: Column(
          children: [
            Image.asset(
              isGadget == true ? 'assets/empty.png' : 'assets/emtyCart.jpg',
              height: MediaQuery.of(context).size.height * .3,
            ),
            Text(
              emptyText,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
