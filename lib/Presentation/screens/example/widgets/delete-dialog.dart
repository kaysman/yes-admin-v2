import 'package:flutter/material.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Are you sure for \'DELETE\'' '?'),
        SizedBox(
          height: 14,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Theme.of(context).dividerColor),
                foregroundColor: Theme.of(context).colorScheme.onSurface,
              ),
              child: const Text('Cancel'),
            ),
            const SizedBox(
              width: 8,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
              ),
              child: const Text('Yes'),
            )
          ],
        ),
      ],
    );
  }
}
