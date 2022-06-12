import 'package:admin_v2/Data/models/sidebar_item.dart';
import 'package:admin_v2/Presentation/screens/products/product-create.dart';
import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'package:flutter/material.dart';

SidebarItem getProductSidebarItem() {
  return SidebarItem(
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
            onPressed: () {
              showAppDialog(context, CreateProductPage());
            },
            child: Text(
              'Haryt döret',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ];
    },
  );
}
