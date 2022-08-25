import 'package:admin_v2/Presentation/screens/brands/bloc/brand.bloc.dart';
import 'package:admin_v2/Presentation/screens/categories/bloc/category.state.dart';
import 'package:admin_v2/Presentation/screens/example/widgets/tiles_box.dart';
import 'package:admin_v2/Presentation/screens/products/dialogs/product-create-info.dialog.dart';
import 'package:faker/faker.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../brands/bloc/brand.state.dart';
import '../categories/bloc/category..bloc.dart';

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
  late BrandBloc brandBloc;
  late CategoryBloc categoryBloc;

  @override
  void initState() {
    categoryBloc = BlocProvider.of<CategoryBloc>(context);
    brandBloc = BlocProvider.of<BrandBloc>(context);

    brandBloc.getAllBrands();
    categoryBloc.getAllCategories();

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 24),
              child: Text(
                'Dashboard',
                style: FluentTheme.of(context).typography.title,
              )),
          Expanded(
            child: GridView.count(
              padding: EdgeInsets.all(20),
              crossAxisCount: 3,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              children: [
                BlocBuilder<BrandBloc, BrandState>(
                  builder: (context, state) {
                    var brand = state.brands != null && state.brands!.isNotEmpty
                        ? state.brands?.first
                        : null;
                    return TilesBox(
                      title: 'Brands',
                      faker: faker,
                      brand: brand,
                      color: Colors.red,
                      controller: animationController,
                    );
                  },
                ),
                BlocBuilder<CategoryBloc, CategoryState>(
                  builder: (context, state) {
                    var subs = getSubs(state.categories);
                    return TilesBox(
                      faker: faker,
                      title: 'Categories',
                      category: subs.isNotEmpty ? subs.first : null,
                      color: Colors.green,
                      controller: animationController,
                    );
                  },
                ),
                TilesBox(
                  title: 'Filters',
                  faker: faker,
                  color: Colors.teal,
                  controller: animationController,
                ),
                TilesBox(
                  title: 'Markets',
                  faker: faker,
                  color: Colors.orange,
                  controller: animationController,
                ),
                TilesBox(
                  title: 'Products',
                  faker: faker,
                  color: Colors.purple,
                  controller: animationController,
                ),
                TilesBox(
                  title: 'Orders',
                  faker: faker,
                  color: Colors.magenta,
                  controller: animationController,
                ),
              ],
            ),
          ),
        ],
      ),
      // Column(
      //   children: [
      //     Expanded(
      //       flex: 2,
      //       child: Row(
      //         children: [
      //           Expanded(
      //               // flex: 2,
      //               child: TilesBox(
      //             faker: faker,
      //             title: 'Brands',
      //             color: Color.fromARGB(255, 199, 252, 138),
      //             controller: animationController,
      //           )),
      //           Expanded(
      //               // flex: 2,
      //               child: TilesBox(
      //             faker: faker,
      //             title: 'Markets',
      //             color: Color.fromARGB(255, 219, 231, 255),
      //             controller: animationController,
      //           )),
      //           Expanded(
      //               // flex: 2,
      //               child: TilesBox(
      //             faker: faker,
      //             title: 'Filters',
      //             color: Color.fromARGB(255, 255, 246, 237),
      //             controller: animationController,
      //           )),
      //         ],
      //       ),
      //     ),
      //     Expanded(
      //       flex: 3,
      //       child: Row(
      //         children: [
      //           Expanded(child: Container(color: Colors.white)),
      //           Expanded(child: Container(color: Colors.warningPrimaryColor)),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
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
