import 'package:admin_v2/Data/models/product/size.model.dart';
import 'package:admin_v2/Presentation/screens/products/bloc/product.bloc.dart';
import 'package:admin_v2/Presentation/screens/products/bloc/product.state.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/components/button.dart';
import 'package:admin_v2/Presentation/shared/components/porudct-view-info.dialog.dart';
import 'package:admin_v2/Presentation/shared/components/view-info.dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductInfo extends StatefulWidget {
  const ProductInfo({Key? key, required this.selectedProductId})
      : super(key: key);
  final int? selectedProductId;
  @override
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  late ProductBloc productBloc;

  @override
  void initState() {
    super.initState();
    productBloc = BlocProvider.of<ProductBloc>(context);
    if (widget.selectedProductId != null) {
      productBloc.getProductById(widget.selectedProductId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductBloc, ProductState>(
      listenWhen: (s1, s2) => s1.selectedProduct != s2.selectedProduct,
      listener: (context, state) {},
      builder: (context, state) {
        if (state.getProductByIdStatus == GetProductByIdStatus.loading) {
          return SizedBox(
            width: MediaQuery.of(context).size.width * .3,
            height: MediaQuery.of(context).size.width * .3,
            child: Center(
              child: CircularProgressIndicator(
                color: kswPrimaryColor,
              ),
            ),
          );
        }
        if (state.getProductByIdStatus == GetProductByIdStatus.error) {
          return SizedBox(
            width: MediaQuery.of(context).size.width * .3,
            height: MediaQuery.of(context).size.width * .3,
            child: Center(
              child: TryAgainButton(
                tryAgain: () async {
                  if (widget.selectedProductId != null) {
                    await productBloc.getProductById(widget.selectedProductId!);
                  }
                },
              ),
            ),
          );
        }
        var product = state.selectedProduct;
        var sizes = product?.sizes;
        var productQuantity = getSum(sizes);
        print(sizes);

        return ProductViewInfoDialog(
          infoTitle: 'Haryt barada',
          infoChildren: [
            InfoChild(
                title: 'Harydyn ady-tm :',
                subTitle: '${product?.name_tm ?? "-"}'),
            SizedBox(
              height: 10,
            ),
            InfoChild(
                title: 'Harydyn ady-ru:',
                subTitle: '${product?.name_ru ?? "-"}'),
            SizedBox(
              height: 10,
            ),
            InfoChild(
              title: 'Harydyn mukdary :',
              subTitle: '${productQuantity} sany',
            ),
            SizedBox(
              height: 10,
            ),
            InfoChild(
              title: 'Harydyn YES bahasy :',
              subTitle: '${product?.ourPrice ?? "-"} TMT',
            ),
            SizedBox(
              height: 10,
            ),
            InfoChild(
              title: 'Harydyn market bahasy :',
              subTitle: '${product?.marketPrice ?? "-"} TMT',
            ),
            SizedBox(
              height: 10,
            ),
            InfoChild(
              title: 'Harydyn kody :',
              subTitle: '${product?.code ?? "-"}',
            ),
            SizedBox(
              height: 10,
            ),
            InfoChild(
              title: 'Harydyn kategoriyasy :',
              subTitle: '${product?.category?.title_tm ?? "-"}',
            ),
            SizedBox(
              height: 10,
            ),
            InfoChild(
              title: 'Harydyn markedi :',
              subTitle: '${product?.market?.title ?? "-"}',
            ),
            SizedBox(
              height: 10,
            ),
            InfoChild(
              title: 'Harydyn brendy :',
              subTitle: '${product?.brand?.name ?? "-"}',
            ),
            SizedBox(
              height: 10,
            ),
            InfoChild(
              title: 'Harydyn jynsy :',
              subTitle: '${product?.gender?.name_tm ?? "-"}',
            ),
            SizedBox(
              height: 10,
            ),
            InfoChild(
              title: 'Harydyn renki :',
              subTitle: '${product?.color?.name_tm ?? "-"}',
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Harydyn olcegleri',
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        fontSize: 20,
                        color: kGrey1Color,
                      ),
                ),
                Wrap(
                  spacing: 5,
                  children: sizes
                          ?.map(
                            (e) => Text.rich(
                              TextSpan(
                                  text: '${e.name_tm ?? '-'}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      ?.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: kText2Color,
                                      ),
                                  children: [
                                    TextSpan(
                                      text: ' x ${e.quantity ?? '-'}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          ?.copyWith(
                                            fontWeight: FontWeight.normal,
                                            color: kGrey1Color,
                                          ),
                                    ),
                                  ]),
                            ),
                            // Text(
                            // ),
                          )
                          .toList() ??
                      [],
                )
              ],
            )
          ],
          imageTitle: 'Harydyn suartlary',
          images: product?.images ?? [],
          sizes: product?.sizes ?? [],
          sizeTitle: 'Harydyn olcegleri',
        );
      },
    );
  }

  int getSum(List<SizeEntity>? sizes) {
    List<int> my = [];
    if (sizes != null) {
      for (var size in sizes) {
        my.add(size.quantity!);
      }
    }
    var sum = my.reduce((a, b) => a + b);
    return sum;
  }
}
