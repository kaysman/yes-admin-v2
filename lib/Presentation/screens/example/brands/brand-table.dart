// import 'package:admin_v2/Data/models/brand/brand.model.dart';
// import 'package:admin_v2/Data/models/product/filter-for-product.model.dart';
// import 'package:admin_v2/Presentation/screens/example/brands/brands-tree.dart';
// import 'package:admin_v2/Presentation/screens/example/widgets/back-button.dart';
// import 'package:admin_v2/Presentation/screens/products/bloc/product.bloc.dart';
// import 'package:admin_v2/Presentation/screens/products/product-create.dart';
// import 'package:admin_v2/Presentation/screens/products/product-table.dart';
// import 'package:admin_v2/Presentation/shared/app_colors.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'widgets/brand-product-search.dart';

// class MaterialBrandTable extends StatefulWidget {
//   const MaterialBrandTable({Key? key, this.brand}) : super(key: key);
//   final BrandEntity? brand;

//   @override
//   State<MaterialBrandTable> createState() => _MaterialBrandTableState();
// }

// class _MaterialBrandTableState extends State<MaterialBrandTable> {
//   final autoSuggestBox = TextEditingController();
//   late ProductBloc productBloc;
//   BrandEntity? selectedBrand;

//   @override
//   void initState() {
//     productBloc = BlocProvider.of<ProductBloc>(context);
//     if (widget.brand != null) {
//       selectedBrand = widget.brand;
//       productBloc.getAllProducts(
//         filter: FilterForProductDTO(brand_id: widget.brand?.id),
//       );
//     }
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Brand Table',
//           style: Theme.of(context).textTheme.titleLarge,
//         ),
//         actions: [
//           IconButton(
//             onPressed: () async {
//               await showDialog(
//                 context: context,
//                 builder: (context) => BrandProductSearch(
//                   selectedBrand: selectedBrand,
//                 ),
//               );
//             },
//             icon: const Icon(Icons.search),
//           ),
//           IconButton(
//             onPressed: () {
//               showDialog(
//                 context: context,
//                 builder: (context) => ProductCreateDialog(),
//               );
//             },
//             icon: const Icon(Icons.add),
//           ),
//         ],
//       ),
//       body: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             color: kGrey5Color.withOpacity(.6),
//             child: BrandTreeViewImpl(
//               onBrandIdChanged: (v) {
//                 // log(v);
//                 setState(() {
//                   selectedBrand = v;
//                 });
//                 productBloc.getAllProducts(
//                   filter: FilterForProductDTO(brand_id: v.id),
//                 );
//               },
//             ),
//           ),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     TableBackButton(),
//                     const SizedBox(
//                       width: 14,
//                     ),
//                     Text('Products of ${selectedBrand?.name}'),
//                   ],
//                 ),
//                 ProductsTable(
//                   emtyText: 'Brenda degisli haryt, yok!',
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
