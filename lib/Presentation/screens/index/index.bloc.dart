import 'package:admin_v2/Presentation/screens/brands/brand-table.dart';
import 'package:admin_v2/Presentation/screens/categories/category-table.dart';
import 'package:admin_v2/Presentation/screens/home-gadgets/gadget-table.dart';
import 'package:admin_v2/Presentation/screens/index/index.screen.dart';
import 'package:admin_v2/Presentation/screens/products/product-table.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_v2/Data/models/sidebar_item.dart';
import 'package:admin_v2/Presentation/screens/markets/market-table.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../filters/filter-table.dart';

class IndexBloc extends Cubit<IndexState> {
  IndexBloc() : super(IndexState(items: sidebars));

  changeItem(SidebarItem v) => emit(state.copyWith(selected: v));
}

class IndexState {
  final List<SidebarItem> items;
  final SidebarItem? selected;

  IndexState({this.items = const [], this.selected});

  IndexState copyWith({
    List<SidebarItem>? items,
    SidebarItem? selected,
  }) {
    return IndexState(
      items: items ?? this.items,
      selected: selected ?? this.selected,
    );
  }
}

List<SidebarItem> sidebars = [
  SidebarItem(
    title: "Dashboard",
    logo: SvgPicture.asset(
      'assets/dashboard.svg',
      width: 30,
      height: 30,
      fit: BoxFit.contain,
      color: kswPrimaryColor,
    ),
    view: DashBoard(),
  ),
  getMarketSidebarItem(),
  getBrandSidebarItem(),
  getFiltesSidebarItem(),
  getCategoriesdebarItem(),
  SidebarItem(
      title: "Aksiýalar",
      logo: Icon(
        Icons.discount_outlined,
        size: 30,
        color: kswPrimaryColor,
      ),
      view: Container(),
      getActions: (context) {
        return [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                onSurface: Colors.white,
                primary: Colors.transparent,
              ),
              onPressed: () {},
              child: Text(
                'Aksiýa döret',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ];
      }),
  SidebarItem(
    title: "Zakazlar",
    logo: SvgPicture.asset(
      'assets/bag.svg',
      width: 30,
      height: 30,
      fit: BoxFit.contain,
      color: kswPrimaryColor,
    ),
    view: Container(),
  ),
  getMainPageSidebarItem(),
  getProductSidebarItem(),
];
