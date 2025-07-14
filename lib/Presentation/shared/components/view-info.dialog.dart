import 'package:admin_v2/Data/models/category/category.model.dart';
import 'package:admin_v2/Data/models/product/product.model.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:flutter/material.dart';

class ViewInfoDialog extends StatelessWidget {
  ViewInfoDialog({
    super.key,
    required this.products,
    required this.infoChildren,
    required this.infoTitle,
    required this.productTitle,
    this.hasSubItems = false,
    this.categorySubItems,
    this.subItemsTitle,
  });

  final List<Widget> infoChildren;
  final String infoTitle;
  final String productTitle;
  final List<ProductEntity> products;
  final List<CategoryEntity>? categorySubItems;
  final String? subItemsTitle;

  bool hasSubItems;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      width: MediaQuery.of(context).size.width * .4,
      child: ListView(
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.close),
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Text(
            infoTitle,
            style:
                Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 24),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: infoChildren,
          ),
          if (hasSubItems && categorySubItems != null) ...[
            SizedBox(
              height: 24,
            ),
            ExpansionTile(
              tilePadding: EdgeInsets.zero,
              title: Text.rich(
                TextSpan(
                  text: subItemsTitle,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(fontSize: 24),
                  children: [
                    TextSpan(text: ' : jemi ${categorySubItems?.length} sany')
                  ],
                ),
              ),
              childrenPadding: const EdgeInsets.only(top: 20, bottom: 10),
              children: [
                GridView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2.5,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                  ),
                  children: List.generate(
                    categorySubItems?.length ?? 1,
                    (i) {
                      if (categorySubItems!.isEmpty) {
                        return Text(
                          'sub yok...',
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
                                    fontSize: 24,
                                    color: kGrey2Color,
                                  ),
                        );
                      }
                      var category = categorySubItems![i];
                      return Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: kGrey5Color.withOpacity(.5),
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _ProductInfo(
                                  title: 'Katigoriyanyn ady-tm:',
                                  subTitle: category.title_tm ?? '-',
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                _ProductInfo(
                                  title: 'Katigoriyanyn ady-ru:',
                                  subTitle: category.title_ru ?? '-',
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                _ProductInfo(
                                  title: 'Katigoriya barada-tm :',
                                  subTitle: category.description_tm ?? '-',
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                _ProductInfo(
                                  title: 'Katigoriya barada-ru :',
                                  subTitle: category.description_ru ?? '-',
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ],
          SizedBox(
            height: 24,
          ),
          ExpansionTile(
            tilePadding: EdgeInsets.zero,
            title: Text.rich(
              TextSpan(
                text: productTitle,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(fontSize: 24),
                children: [TextSpan(text: ' : jemi ${products.length} sany')],
              ),
            ),
            childrenPadding: const EdgeInsets.only(top: 20, bottom: 10),
            children: [
              GridView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2.5,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                ),
                children: List.generate(
                  products.isEmpty ? 1 : products.length,
                  (i) {
                    if (products.isEmpty) {
                      return Text(
                        'haryt yok...',
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              fontSize: 24,
                              color: kGrey2Color,
                            ),
                      );
                    }
                    var product = products[i];
                    return Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: kGrey5Color.withOpacity(.5),
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _ProductInfo(
                                title: 'Harydyn ady :',
                                subTitle: product.name_tm ?? '-',
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              _ProductInfo(
                                title: 'Harydyn market bahasy :',
                                subTitle: product.marketPrice.toString(),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              _ProductInfo(
                                title: 'Harydyn Yes bahasy :',
                                subTitle: product.ourPrice.toString(),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              _ProductInfo(
                                title: 'Harydyn kody :',
                                subTitle: product.code ?? '-',
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class _ProductInfo extends StatelessWidget {
  const _ProductInfo({
    Key? key,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                fontSize: 14,
              ),
        ),
        SizedBox(
          width: 10,
        ),
        // Spacer(),
        Text(
          subTitle,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(fontSize: 14, color: kGrey1Color),
        ),
      ],
    );
  }
}

class InfoChild extends StatelessWidget {
  const InfoChild({
    Key? key,
    required this.title,
    required this.subTitle,
  }) : super(key: key);
  final String title;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                fontSize: 20,
                color: kGrey1Color,
              ),
        ),
        Text(
          subTitle,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(fontSize: 20, color: kGrey1Color),
        ),
      ],
    );
  }
}
