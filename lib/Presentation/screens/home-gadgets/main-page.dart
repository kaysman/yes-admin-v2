import 'package:admin_v2/Data/models/brand/brand.model.dart';
import 'package:admin_v2/Data/models/meta.dart';
import 'package:admin_v2/Data/models/product/pagination.model.dart';
import 'package:admin_v2/Data/models/sidebar_item.dart';
import 'package:admin_v2/Presentation/screens/brands/bloc/brand.bloc.dart';
import 'package:admin_v2/Presentation/screens/brands/bloc/brand.state.dart';
import 'package:admin_v2/Presentation/screens/brands/brand-create.dart';
import 'package:admin_v2/Presentation/screens/home-gadgets/create-main-page.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/components/appbar.components.dart';
import 'package:admin_v2/Presentation/shared/components/pagination.dart';
import 'package:admin_v2/Presentation/shared/components/scrollable.dart';
import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

SidebarItem getMainPageSidebarItem() {
  return SidebarItem(
      title: "Programmanyň Esasy Sahypasy",
      view: Container(),
      getActions: (context) {
        return [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                BlocConsumer<BrandBloc, BrandState>(
                  listener: (_, state) {
                    if (state.createStatus == BrandCreateStatus.success) {
                      Scaffold.of(context)
                          // ignore: deprecated_member_use
                          .showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.lightBlue,
                          behavior: SnackBarBehavior.floating,
                          duration: Duration(milliseconds: 1000),
                          content: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 30,
                            ),
                            child: new Text(
                              'Created Successully',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3
                                  ?.copyWith(
                                      color: Colors.white, letterSpacing: 1),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return SearchFieldInAppBar(
                      hintText: "e.g mb shoes",
                      onEnter: state.listingStatus == BrandListStatus.loading
                          ? null
                          : (value) {
                              // print(value);
                              // context.read<BrandBloc>().getAllBrands(
                              //       filter: PaginationDTO(search: value),
                              //     );
                            },
                    );
                  },
                ),
                SizedBox(
                  width: 14,
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    onSurface: Colors.white,
                    primary: Colors.transparent,
                  ),
                  onPressed: () {
                    showAppDialog(context, CreateMainPage());
                  },
                  child: Text(
                    'Sahypa döret',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ];
      });
}
