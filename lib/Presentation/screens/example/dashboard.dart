import 'package:admin_v2/Presentation/screens/brands/bloc/brand.bloc.dart';
import 'package:admin_v2/Presentation/screens/categories/bloc/category.state.dart';
import 'package:admin_v2/Presentation/screens/example/widgets/tiles_box.dart';
import 'package:admin_v2/Presentation/screens/filters/bloc/filter.bloc.dart';
import 'package:admin_v2/Presentation/screens/markets/bloc/market.state.dart';
import 'package:admin_v2/Presentation/screens/orders/order.bloc.dart';
import 'package:admin_v2/Presentation/screens/products/dialogs/product-create-info.dialog.dart';
import 'package:faker/faker.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../brands/bloc/brand.state.dart';
import '../categories/bloc/category..bloc.dart';
import '../filters/bloc/filter.state.dart';
import '../home-gadgets/bloc/gadget.bloc.dart';
import '../markets/bloc/market.bloc.dart';

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

enum PageType {
  BRAND,
  CATEGORY,
  MARKET,
  FILTER,
  PRODUCT,
  ORDER,
  GADGET,
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
  late MarketBloc marketBloc;
  late FilterBloc filterBloc;
  late OrderBloc orderBloc;
  late GadgetBloc gadgetBloc;

  @override
  void initState() {
    categoryBloc = BlocProvider.of<CategoryBloc>(context);
    brandBloc = BlocProvider.of<BrandBloc>(context);
    marketBloc = BlocProvider.of<MarketBloc>(context);
    filterBloc = BlocProvider.of<FilterBloc>(context);
    orderBloc = BlocProvider.of<OrderBloc>(context);
    gadgetBloc = BlocProvider.of<GadgetBloc>(context);

    brandBloc.getAllBrands();
    categoryBloc.getAllCategories();
    marketBloc.getAllMarkets();
    filterBloc.getAllFilters();
    orderBloc.getAllOrders();
    gadgetBloc.getAllGadgets();

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
                      pageType: PageType.BRAND,
                      imgPath: 'assets/brand.jpg',
                      subTitle: 'Something about brands...',
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
                      pageType: PageType.CATEGORY,
                      imgPath: 'assets/category-page.jpg',
                      subTitle: 'Something about categories...',
                      faker: faker,
                      title: 'Categories',
                      category: subs.isNotEmpty ? subs.first : null,
                      color: Colors.green,
                      controller: animationController,
                    );
                  },
                ),
                BlocBuilder<MarketBloc, MarketState>(
                  builder: (context, state) {
                    var market =
                        state.markets != null && state.markets!.isNotEmpty
                            ? state.markets?.first
                            : null;
                    return TilesBox(
                      market: market,
                      pageType: PageType.MARKET,
                      imgPath: 'assets/market.webp',
                      subTitle: 'Something about markets...',
                      title: 'Markets',
                      faker: faker,
                      color: Colors.orange,
                      controller: animationController,
                    );
                  },
                ),
                BlocBuilder<FilterBloc, FilterState>(
                  builder: (context, state) {
                    var filter =
                        state.filters != null && state.filters!.isNotEmpty
                            ? state.filters?.first
                            : null;
                    return TilesBox(
                      filter: filter,
                      pageType: PageType.FILTER,
                      imgPath: 'assets/filter.webp',
                      subTitle: 'Something about filters...',
                      title: 'Filters',
                      faker: faker,
                      color: Colors.teal,
                      controller: animationController,
                    );
                  },
                ),
                BlocBuilder<GadgetBloc, GadgetState>(
                  builder: (context, state) {
                    return TilesBox(
                      pageType: PageType.GADGET,
                      imgPath: 'assets/gadget1.webp',
                      subTitle: 'Something about gadget...',
                      title: 'Gadgets',
                      faker: faker,
                      color: Colors.purple,
                      controller: animationController,
                    );
                  },
                ),
                BlocBuilder<OrderBloc, OrderState>(
                  builder: (context, state) {
                    var order = state.orders != null && state.orders!.isNotEmpty
                        ? state.orders?.first
                        : null;
                    return TilesBox(
                      pageType: PageType.ORDER,
                      imgPath: 'assets/order.jpg',
                      subTitle: 'Something about orders...',
                      title: 'Orders',
                      faker: faker,
                      order: order,
                      color: Colors.magenta,
                      controller: animationController,
                    );
                  },
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
