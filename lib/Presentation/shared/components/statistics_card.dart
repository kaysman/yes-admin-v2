import 'package:flutter/material.dart';

class StatisticsCard extends StatelessWidget {
  const StatisticsCard({
    Key? key,
    this.label,
    required this.content,
    required this.description,
  }) : super(key: key);

  final String? label;
  final String content;
  final String description;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      color: colorScheme.surface,
      child: SizedBox(
        width: 100,
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (label != null)
              Text(label!, style: Theme.of(context).textTheme.caption),
            SizedBox(height: 8),
            Text(
              content,
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    color: colorScheme.primary,
                    fontSize: 38,
                  ),
            ),
            SizedBox(height: 8),
            Text(description, style: Theme.of(context).textTheme.caption),
          ],
        ),
      ),
    );
  }
}
