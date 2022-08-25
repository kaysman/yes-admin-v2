import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:admin_v2/Presentation/shared/components/button.dart' as f;

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
            Button(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false);
                Navigator.of(context).pop();
              },
            ),
            SizedBox(
              width: 8,
            ),
            f.Button(
              primary: kswPrimaryColor,
              textColor: kWhite,
              text: 'Yes',
              onPressed: () {
                Navigator.of(context).pop(true);
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ],
    );
  }
}
