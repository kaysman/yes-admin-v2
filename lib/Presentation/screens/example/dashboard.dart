import 'package:admin_v2/Presentation/screens/example/widgets/tiles_box.dart';
import 'package:faker/faker.dart';
import 'package:fluent_ui/fluent_ui.dart';

class Person {
  String name;
  String email;
  String phone;
  String address;

  Person(
    this.name,
    this.email,
    this.phone,
    this.address,
  );
}

class FluentDashboard extends StatefulWidget {
  const FluentDashboard({Key? key}) : super(key: key);

  @override
  State<FluentDashboard> createState() => _FluentDashboardState();
}

class _FluentDashboardState extends State<FluentDashboard>
    with SingleTickerProviderStateMixin {
  final faker = Faker();

  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    super.initState();
  }

  // @override
  // void dispose() {
  //   animationController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // filters
    // brands
    // markets
    // categories
    // gadgets
    // products
    // orders
    return ScaffoldPage(
      padding: EdgeInsets.zero,
      content: Column(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Expanded(
                    // flex: 2,
                    child: TilesBox(
                  faker: faker,
                  title: 'Brands',
                  color: Color.fromARGB(255, 199, 252, 138),
                  controller: animationController,
                )),
                Expanded(
                    // flex: 2,
                    child: TilesBox(
                  faker: faker,
                  title: 'Markets',
                  color: Color.fromARGB(255, 219, 231, 255),
                  controller: animationController,
                )),
                Expanded(
                    // flex: 2,
                    child: TilesBox(
                  faker: faker,
                  title: 'Filters',
                  color: Color.fromARGB(255, 255, 246, 237),
                  controller: animationController,
                )),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Expanded(child: Container(color: Colors.white)),
                Expanded(child: Container(color: Colors.warningPrimaryColor)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  const NextPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('new page');
    return ScaffoldPage(
      header: PageHeader(
        leading: Button(
          child: Icon(FluentIcons.back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      padding: EdgeInsets.all(16),
      content: Container(color: Colors.orange),
    );
  }
}
