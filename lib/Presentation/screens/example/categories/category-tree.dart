import 'package:admin_v2/Data/models/category/category.model.dart';
import 'package:admin_v2/Data/models/category/update-category.model.dart';
import 'package:admin_v2/Presentation/screens/categories/bloc/category..bloc.dart';
import 'package:admin_v2/Presentation/screens/categories/bloc/category.state.dart';
import 'package:admin_v2/Presentation/screens/categories/category-create.dart';
import 'package:admin_v2/Presentation/screens/categories/category-update.dart';
import 'package:admin_v2/Presentation/screens/example/widgets/delete-dialog.dart';
import 'package:admin_v2/Presentation/screens/example/widgets/titled-add-btn.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/tree-view-item-content.dart';

class Category {
  String name;
  List<Category>? subs;

  Category({
    required this.name,
    this.subs,
  });
}

class CategoryTreeViewImpl extends StatefulWidget {
  const CategoryTreeViewImpl({
    Key? key,
    required this.onCategoryChanged,
  }) : super(key: key);

  final ValueChanged<CategoryEntity> onCategoryChanged;

  @override
  State<CategoryTreeViewImpl> createState() => _CategoryTreeViewImplState();
}

class _CategoryTreeViewImplState extends State<CategoryTreeViewImpl> {
  late CategoryBloc categoryBloc;
  int selected_item = 0;

  @override
  void initState() {
    categoryBloc = BlocProvider.of<CategoryBloc>(context);
    if (categoryBloc.state.categories?.isNotEmpty == true) {
      var categories = categoryBloc.state.categories;
      var category = categories?.isNotEmpty == true ? categories?.first : null;
      var subs = category?.subcategories;
      selected_item = subs?.isNotEmpty == true ? subs?.first.id ?? 0 : 0;
    }
    super.initState();
  }

  List<Category> categories = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryBloc, CategoryState>(
      listenWhen: (p, c) =>
          p.listingStatus != c.listingStatus ||
          p.deleteStatus != c.deleteStatus,
      listener: (context, state) {
        if (state.updateStatus == CategoryUpdateStatus.success) {
          showSnackbar(
            context,
            Snackbar(
              content: Text(
                'Updated successfully',
              ),
            ),
          );
        }
        if (state.deleteStatus == CategoryDeleteStatus.success) {
          showSnackbar(
            context,
            Snackbar(
              content: Text(
                'Deleted successfully',
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state.listingStatus == CategoryListStatus.loading) {
          return Center(child: ProgressRing());
        }
        if (state.listingStatus == CategoryListStatus.error) {
          return Text('Error');
        }
        var categories = state.categories;

        return Container(
          color: kGrey5Color.withOpacity(.8),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          width: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitledAddBtn(onAdd: () {}, title: 'Categories'),
              SizedBox(
                height: 8,
              ),
              TreeView(
                items: categories?.map(
                      (e) {
                        return TreeViewItem(
                          backgroundColor: ButtonState.resolveWith(
                            (states) => Colors.white,
                          ),
                          content: TreeViewItemContent(
                            onItemTap: () {},
                            title: e.title_tm ?? '-',
                            onEdit: () async {
                              final res =
                                  await showFluentAppDialog<UpdateCategoryDTO>(
                                context,
                                content: UpdateCategoryPage(
                                  category: e,
                                ),
                              );

                              if (res != null) {
                                await categoryBloc.updateCategory(res);
                              }
                            },
                            onDelete: () async {
                              final res = await showFluentAppDialog<bool>(
                                context,
                                content: DeleteDialog(),
                              );
                              if (res == true && e.id != null) {
                                await categoryBloc.deleteCategory(e.id!);
                              }
                            },
                          ),
                          children: e.subcategories
                                  ?.map(
                                    (e) => TreeViewItem(
                                      backgroundColor: selected_item == e.id
                                          ? ButtonState.resolveWith(
                                              (states) => Colors.grey[20],
                                            )
                                          : ButtonState.resolveWith(
                                              (states) => Colors.white,
                                            ),
                                      content: TreeViewItemContent(
                                        title: e.title_tm ?? '-',
                                        onItemTap: () {
                                          widget.onCategoryChanged.call(e);
                                          setState(() {
                                            selected_item = e.id ?? 0;
                                          });
                                        },
                                        onEdit: () async {
                                          final res = await showFluentAppDialog<
                                              UpdateCategoryDTO>(
                                            context,
                                            content: UpdateCategoryPage(
                                              category: e,
                                            ),
                                          );

                                          if (res != null) {
                                            await categoryBloc
                                                .updateCategory(res);
                                          }
                                        },
                                        onDelete: () async {
                                          final res =
                                              await showFluentAppDialog<bool>(
                                            context,
                                            content: DeleteDialog(),
                                          );
                                          if (res == true && e.id != null) {
                                            await categoryBloc
                                                .deleteCategory(e.id!);
                                          }
                                        },
                                      ),
                                    ),
                                  )
                                  .toList() ??
                              [],
                        );
                      },
                    ).toList() ??
                    [],
              ),
            ],
          ),
        );
      },
    );
  }
}
