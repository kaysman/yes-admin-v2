import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_v2/Data/models/sidebar_item.dart';
import 'package:admin_v2/Presentation/screens/markets/market-table.dart';

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
  getMarketSidebarItem(),
  SidebarItem(
      title: "Brendlar",
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
                'Brend döret',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ];
      }),
  SidebarItem(
      title: "Aksiýalar",
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
    view: Container(),
  ),
  SidebarItem(
    title: "Programmanyň Esasy Sahypasy",
    view: Container(),
  ),
  SidebarItem(
      title: "Harytlar",
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
                'Haryt döret',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ];
      }),
];
