import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:fluent_ui/fluent_ui.dart';
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
          FluentIcons.back,
          color: kBlack,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
