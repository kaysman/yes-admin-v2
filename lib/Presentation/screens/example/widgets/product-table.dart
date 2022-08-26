import 'package:admin_v2/Data/models/product/product.model.dart';
import 'package:admin_v2/Presentation/screens/products/bloc/product.state.dart';
import 'package:admin_v2/Presentation/screens/products/product-create.dart';
import 'package:admin_v2/Presentation/screens/products/product-update.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../products/bloc/product.bloc.dart';

class TableProducts extends StatefulWidget {
  const TableProducts({
    Key? key,
  }) : super(key: key);
  // final ProductEntity hoveredP;

  @override
  State<TableProducts> createState() => _TableProductsState();
}

class _TableProductsState extends State<TableProducts> {
  ProductEntity? hoveredP;

  @override
  Widget build(BuildContext buildContext) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: MediaQuery.of(buildContext).size.width,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[10],
              ),
              padding: const EdgeInsets.only(
                left: 54,
                top: 14,
                bottom: 14,
              ),
              // height: 100,
              child: Row(
                children: [
                  Expanded(child: Text('name')),
                  Expanded(child: Text('image')),
                  Expanded(child: Text('brand')),
                  Expanded(child: Text('category')),
                  Expanded(child: Text('color')),
                  Expanded(child: Text('gender')),
                  Expanded(child: Text('market')),
                  Expanded(child: Text('YES price')),
                  Expanded(child: Text('Market price')),
                  Expanded(child: Text('Description tm')),
                  Expanded(child: Text('Description ru')),
                ],
              ),
            ),
            SizedBox(
              height: 14,
            ),
            BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state.listingStatus == ProductListStatus.loading) {
                  return Center(child: ProgressRing());
                }
                var p = state.products;
                return p?.isEmpty == true
                    ? Image.asset(
                        'assets/emtyCart.jpg',
                        // width: ,
                      )
                    : SizedBox(
                        height: MediaQuery.of(context).size.height - 200,
                        child: ListView(
                          children: List.generate(
                            p?.length ?? 0,
                            (index) {
                              var product = p?[index];
                              var image =
                                  product != null && product.images != null
                                      ? product.images!.isNotEmpty
                                          ? product.images?.first
                                          : null
                                      : null;
                              var selected = hoveredP == product;
                              return MouseRegion(
                                onHover: (v) {
                                  setState(() {
                                    hoveredP = product;
                                  });
                                },
                                child: Stack(
                                  alignment: Alignment.centerRight,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                      ),
                                      child: Container(
                                        height: 100,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                          color: kGrey3Color,
                                        ))),
                                        child: ListTile(
                                          tileColor:
                                              selected ? Colors.grey[10] : null,
                                          leading: SizedBox(
                                            width: 50,
                                            child: CircleAvatar(
                                              backgroundColor: Colors.green,
                                              child: Center(
                                                  child: Text(product
                                                          ?.name_tm?[0]
                                                          .toUpperCase() ??
                                                      '-')),
                                            ),
                                          ),
                                          title: SizedBox(
                                            // height: 300,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                      product?.name_tm ?? '-',
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                ),
                                                Expanded(
                                                  child: SizedBox(
                                                    // width: 40,
                                                    child:
                                                        image?.getFullPathImage ==
                                                                null
                                                            ? SizedBox()
                                                            : ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                  8,
                                                                ),
                                                                child: Image
                                                                    .network(
                                                                  image!
                                                                      .getFullPathImage!,
                                                                  height: 85,
                                                                  // fit: BoxFit.fitWidth,
                                                                ),
                                                              ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    product?.brand?.name ?? '-',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    product?.category
                                                            ?.title_tm ??
                                                        '-',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    product?.color?.name_tm ??
                                                        '-',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    product?.gender?.name_tm ??
                                                        '-',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    product?.market?.title ??
                                                        '-',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    '${product?.ourPrice ?? '-'}',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    '${product?.marketPrice ?? '-'}',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    '${product?.description_tm ?? '-'}',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    '${product?.description_ru ?? '-'}',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (selected)
                                      Positioned(
                                          right: 10,
                                          child:
                                              // Button(
                                              //   child: Text('Edit'),
                                              //   onPressed: () async {
                                              //     await showFluentAppDialog(
                                              //       context,
                                              //       content: ProductUpdateDialog(
                                              //         product: hoveredP!,
                                              //       ),
                                              //     );
                                              //   },
                                              // )
                                              Container(
                                            decoration: BoxDecoration(
                                                color: kGrey2Color,
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            width: 35,
                                            child: CommandBar(
                                              compactBreakpointWidth: 40,
                                              overflowBehavior:
                                                  CommandBarOverflowBehavior
                                                      .clip,
                                              primaryItems: [
                                                // CommandBarButton(
                                                //   label: Row(
                                                //     mainAxisSize:
                                                //         MainAxisSize.min,
                                                //     children: [
                                                //       Text('Edit'),
                                                //     ],
                                                //   ),
                                                //   icon: Icon(
                                                //     FluentIcons.edit,
                                                //   ),
                                                //   onPressed: () {},
                                                // ),
                                              ],
                                              secondaryItems: [
                                                CommandBarButton(
                                                  label: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text('Edit'),
                                                    ],
                                                  ),
                                                  icon: Icon(
                                                    FluentIcons.edit,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      hoveredP = product;
                                                    });
                                                    showFluentAppDialog(
                                                      context,
                                                      content:
                                                          ProductUpdateDialog(
                                                        product: product!,
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          )),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
