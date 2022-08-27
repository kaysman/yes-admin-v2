import 'package:admin_v2/Presentation/screens/example/dashboard.dart';
import 'package:fluent_ui/fluent_ui.dart';

class EmtyProductView extends StatelessWidget {
  const EmtyProductView({
    Key? key,
    required this.emtyText,
  }) : super(key: key);
  final String emtyText;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .8,
      child: Center(
        child: Column(
          children: [
            Image.asset(
              'assets/emtyCart.jpg',
              height: MediaQuery.of(context).size.height * .3,
            ),
            Text(
              emtyText,
              style: FluentTheme.of(context).typography.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
