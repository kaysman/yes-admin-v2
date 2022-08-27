import 'package:admin_v2/Data/models/brand/brand.model.dart';
import 'package:admin_v2/Data/models/category/sub.model.dart';
import 'package:admin_v2/Data/models/filter/filter.entity.model.dart';
import 'package:admin_v2/Data/models/market/market.model.dart';
import 'package:admin_v2/Presentation/screens/example/brands/brand-table.dart';
import 'package:admin_v2/Presentation/screens/example/categories/category-table.dart';
import 'package:admin_v2/Presentation/screens/example/dashboard.dart';
import 'package:admin_v2/Presentation/screens/example/filters/filter-table.dart';
import 'package:admin_v2/Presentation/screens/example/markets/market-table.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/theming.dart';
import 'package:faker/faker.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as mt;

class TilesBox extends StatefulWidget {
  const TilesBox({
    Key? key,
    required this.title,
    required this.faker,
    required this.color,
    required this.controller,
    this.brand,
    this.category,
    required this.subTitle,
    required this.imgPath,
    required this.pageType,
    this.market,
    this.filter,
  }) : super(key: key);

  final Faker faker;
  final BrandEntity? brand;
  final FilterEntity? filter;
  final MarketEntity? market;
  final SubItem? category;
  final String title;
  final String subTitle;
  final String imgPath;
  final Color color;
  final PageType pageType;
  final AnimationController controller;

  @override
  State<TilesBox> createState() => _TilesBoxState();
}

class _TilesBoxState extends State<TilesBox> {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          FluentPageRoute(builder: (context) {
            switch (widget.pageType) {
              case PageType.BRAND:
                return FluentBrandTable(
                  brand: widget.brand,
                );
              case PageType.CATEGORY:
                return FluentCategoryTable(
                  category: widget.category,
                );
              case PageType.MARKET:
                return FluentMarketTable(
                  market: widget.market,
                );
              case PageType.FILTER:
                return FluentFilterTable(
                  filter: widget.filter,
                );
              case PageType.PRODUCT:
                return FluentCategoryTable(
                  category: widget.category,
                );
              case PageType.ORDER:
                return FluentCategoryTable(
                  category: widget.category,
                );

              default:
                return SizedBox();
            }
          }),
        );
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onHover: (v) {
          setState(() {
            isHover = true;
          });
        },
        onExit: (v) {
          setState(() {
            isHover = false;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: kGrey4Color),
            boxShadow: isHover ? kBoxHover : null,
          ),
          child: buildTiles(context),
        ),
      ),
    );
  }

  buildTiles(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          widget.imgPath,
          height: 300,
          width: double.infinity,
          fit: BoxFit.fill,
        ),
        Expanded(
          child: Container(
            color: kWhite,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            height: 100,
            child: Container(
              // color: kG,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.title,
                        style: FluentTheme.of(context).typography.title,
                      ),
                      CircleAvatar(
                        backgroundColor: kGrey4Color,
                        child: Container(
                          padding: const EdgeInsets.all(7),
                          child: Image.asset(
                            'assets/brandLogo.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Text(
                    widget.subTitle,
                    style: FluentTheme.of(context)
                        .typography
                        .body
                        ?.copyWith(color: kGrey1Color),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
