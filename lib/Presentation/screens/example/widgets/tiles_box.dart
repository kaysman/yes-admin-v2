// import 'package:admin_v2/Data/models/brand/brand.model.dart';
// import 'package:admin_v2/Data/models/category/sub.model.dart';
// import 'package:admin_v2/Data/models/filter/filter.entity.model.dart';
// import 'package:admin_v2/Data/models/gadget/gadget.model.dart';
// import 'package:admin_v2/Data/models/market/market.model.dart';
// import 'package:admin_v2/Data/models/order/order.model.dart';
// import 'package:admin_v2/Presentation/screens/example/dashboard.dart';
// import 'package:admin_v2/Presentation/shared/app_colors.dart';
// import 'package:admin_v2/Presentation/shared/theming.dart';
// import 'package:faker/faker.dart';
// import 'package:flutter/material.dart';
// // import 'package:flutter/material.dart' as mt;

// class TilesBox extends StatefulWidget {
//   const TilesBox({
//     Key? key,
//     required this.title,
//     required this.faker,
//     required this.color,
//     required this.controller,
//     this.brand,
//     this.category,
//     required this.subTitle,
//     required this.imgPath,
//     required this.pageType,
//     this.market,
//     this.filter,
//     this.order,
//     this.gadget,
//   }) : super(key: key);

//   final Faker faker;
//   final BrandEntity? brand;
//   final FilterEntity? filter;
//   final MarketEntity? market;
//   final GadgetEntity? gadget;
//   final OrderEntity? order;
//   final SubItem? category;
//   final String title;
//   final String subTitle;
//   final String imgPath;
//   final Color color;
//   final PageType pageType;
//   final AnimationController controller;

//   @override
//   State<TilesBox> createState() => _TilesBoxState();
// }

// class _TilesBoxState extends State<TilesBox> {
//   bool isHover = false;
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) {
//             switch (widget.pageType) {
//               case PageType.BRAND:
//                 return BrandTable(
//                   brand: widget.brand,
//                 );
//               case PageType.CATEGORY:
//                 return CategoryTable(
//                   category: widget.category,
//                 );
//               case PageType.MARKET:
//                 return MarketTable(
//                   market: widget.market,
//                 );
//               case PageType.FILTER:
//                 return FilterTable(
//                   filter: widget.filter,
//                 );
//               case PageType.GADGET:
//                 return GadgetTable(
//                   gadget: widget.gadget,
//                 );
//               case PageType.ORDER:
//                 return OrderTable(
//                   order: widget.order,
//                 );

//               default:
//                 return SizedBox();
//             }
//           }),
//         );
//       },
//       child: MouseRegion(
//         cursor: SystemMouseCursors.click,
//         onHover: (v) {
//           setState(() {
//             isHover = true;
//           });
//         },
//         onExit: (v) {
//           setState(() {
//             isHover = false;
//           });
//         },
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             border: Border.all(color: kGrey4Color),
//             boxShadow: isHover ? kBoxHover : null,
//           ),
//           child: buildTiles(context),
//         ),
//       ),
//     );
//   }

//   buildTiles(BuildContext context) {
//     return LayoutBuilder(builder: (context, constraints) {
//       // log(constraints.maxWidth);
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Image.asset(
//             widget.imgPath,
//             height: constraints.maxWidth > 400
//                 ? 300
//                 : constraints.maxWidth > 350
//                     ? 200
//                     : constraints.maxWidth > 250
//                         ? 150
//                         : 100,
//             width: double.infinity,
//             fit: BoxFit.fill,
//           ),
//           Expanded(
//             child: Container(
//               color: kWhite,
//               padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         widget.title,
//                         style: constraints.maxWidth > 400
//                             ? Theme.of(context).textTheme.titleLarge
//                             : constraints.maxWidth > 300
//                                 ? Theme.of(context)
//                                     .textTheme
//                                     .titleLarge
//                                     ?.copyWith(
//                                       fontSize: 24,
//                                     )
//                                 : Theme.of(context)
//                                     .textTheme
//                                     .titleLarge
//                                     ?.copyWith(
//                                       fontSize: 18,
//                                     ),
//                       ),
//                       CircleAvatar(
//                         backgroundColor: kGrey4Color,
//                         child: Container(
//                           padding: const EdgeInsets.all(7),
//                           child: Image.asset(
//                             'assets/brandLogo.png',
//                             fit: BoxFit.contain,
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                   SizedBox(
//                     height: 14,
//                   ),
//                   Text(
//                     widget.subTitle,
//                     style: Theme.of(context)
//                         .textTheme
//                         .bodyMedium
//                         ?.copyWith(color: kGrey1Color),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       );
//     });
//   }
// }
