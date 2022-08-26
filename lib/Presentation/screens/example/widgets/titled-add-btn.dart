import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:fluent_ui/fluent_ui.dart';

class TitledAddBtn extends StatelessWidget {
  const TitledAddBtn({
    Key? key,
    required this.onAdd,
    required this.title,
  }) : super(key: key);
  final VoidCallback onAdd;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: FluentTheme.of(context).typography.body?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
          IconButton(
            style: ButtonStyle(backgroundColor: ButtonState.all(kGrey3Color)),
            icon: Icon(
              FluentIcons.add,
              // color: kWhite,
            ),
            onPressed: onAdd,
          ),
        ],
      ),
    );
  }
}
