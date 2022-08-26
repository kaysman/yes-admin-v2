import 'package:admin_v2/Data/models/brand/brand.model.dart';
import 'package:admin_v2/Presentation/screens/brands/brand-create.dart';
import 'package:admin_v2/Presentation/screens/brands/brand-update.dart';
import 'package:admin_v2/Presentation/screens/example/widgets/delete-dialog.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/components/button.dart' as f;
import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../brands/bloc/brand.bloc.dart';
import '../../brands/bloc/brand.state.dart';
import '../widgets/titled-add-btn.dart';
import '../widgets/tree-view-item-content.dart';

class Category {
  String name;
  List<Category>? subs;

  Category({
    required this.name,
    this.subs,
  });
}

class BrandTreeViewImpl extends StatefulWidget {
  const BrandTreeViewImpl({
    Key? key,
    required this.onBrandIdChanged,
  }) : super(key: key);

  final ValueChanged<BrandEntity> onBrandIdChanged;

  @override
  State<BrandTreeViewImpl> createState() => _BrandTreeViewImplState();
}

class _BrandTreeViewImplState extends State<BrandTreeViewImpl> {
  late BrandBloc brandBloc;
  int selected_item = 0;
  String? action;
  BrandEntity? brand;

  @override
  void initState() {
    brandBloc = BlocProvider.of<BrandBloc>(context);
    if (brandBloc.state.brands?.isNotEmpty == true) {
      var brand = brandBloc.state.brands?.first;
      selected_item = brand?.id ?? 0;
    }
    super.initState();
  }

  List<Category> categories = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BrandBloc, BrandState>(
      listenWhen: (p, c) =>
          p.listingStatus != c.listingStatus ||
          p.createStatus != c.createStatus ||
          p.brandDeleteStatus != c.brandDeleteStatus,
      listener: (context, state) {
        // log(state.brandUpdateStatus);
        if (state.brandUpdateStatus == BrandUpdateStatus.success) {
          showSnackbar(
            context,
            Snackbar(
              content: Text(
                'Updated successfully',
              ),
            ),
          );
        }
        if (state.brandDeleteStatus == BrandDeleteStatus.success) {
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
        if (state.listingStatus == BrandListStatus.loading) {
          return Center(child: ProgressRing());
        }
        if (state.listingStatus == BrandListStatus.error) {
          return f.TryAgainButton(tryAgain: () {
            brandBloc.getAllBrands();
          });
        }
        var brands = state.brands;

        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
          ),
          width: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TitledAddBtn(
                onAdd: () {
                  showFluentAppDialog(
                    context,
                    content: CreateBrandPage(),
                  );
                },
                title: 'Brands',
              ),
              SizedBox(
                height: 8,
              ),
              TreeView(
                items: brands?.map(
                      (e) {
                        return TreeViewItem(
                          backgroundColor: selected_item == e.id
                              ? ButtonState.resolveWith(
                                  (states) => Colors.grey[20],
                                )
                              : ButtonState.resolveWith(
                                  (states) => Colors.white,
                                ),
                          content: TreeViewItemContent(
                            title: e.name ?? '-',
                            onItemTap: () {
                              widget.onBrandIdChanged.call(e);
                              setState(() {
                                selected_item = e.id;
                              });
                            },
                            onEdit: () async {
                              final res = await showFluentAppDialog<
                                  Map<String, dynamic>>(
                                context,
                                content: UpdateBrandPage(
                                  brand: e,
                                ),
                              );

                              if (res != null) {
                                await brandBloc.updateBrand(
                                  res['files'],
                                  res['data'],
                                );
                              }
                            },
                            onDelete: () async {
                              final res = await showFluentAppDialog<bool>(
                                context,
                                content: DeleteDialog(),
                              );
                              if (res == true) {
                                await brandBloc.deleteBrand(e.id);
                              }
                            },
                          ),
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
