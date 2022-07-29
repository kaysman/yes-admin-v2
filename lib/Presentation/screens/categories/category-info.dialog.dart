import 'package:admin_v2/Presentation/screens/categories/bloc/category..bloc.dart';
import 'package:admin_v2/Presentation/screens/categories/bloc/category.state.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/components/button.dart';
import 'package:admin_v2/Presentation/shared/components/view-info.dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryInfo extends StatefulWidget {
  const CategoryInfo({Key? key, required this.selectedCategoryId})
      : super(key: key);
  final int? selectedCategoryId;
  @override
  State<CategoryInfo> createState() => _CategoryInfoState();
}

class _CategoryInfoState extends State<CategoryInfo> {
  late CategoryBloc categoryBloc;

  @override
  void initState() {
    super.initState();
    categoryBloc = BlocProvider.of<CategoryBloc>(context);
    if (widget.selectedCategoryId != null) {
      categoryBloc.getCategoryById(widget.selectedCategoryId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryBloc, CategoryState>(
      listenWhen: (s1, s2) => s1.selectedCategory != s2.selectedCategory,
      listener: (context, state) {},
      builder: (context, state) {
        if (state.getCategoryByIdStatus == GetCategoryByIdStatus.loading) {
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
        if (state.getCategoryByIdStatus == GetCategoryByIdStatus.error) {
          return SizedBox(
            width: MediaQuery.of(context).size.width * .3,
            height: MediaQuery.of(context).size.width * .3,
            child: Center(
              child: TryAgainButton(
                tryAgain: () async {
                  if (widget.selectedCategoryId != null) {
                    await categoryBloc
                        .getCategoryById(widget.selectedCategoryId!);
                  }
                },
              ),
            ),
          );
        }
        var category = state.selectedCategory;
        return ViewInfoDialog(
          infoTitle: 'Kategoriya barada',
          infoChildren: [
            SizedBox(
              height: 10,
            ),
            InfoChild(
              title: 'Kategoriyanyn ady-tm:',
              subTitle: '${category?.title_tm ?? '-'}',
            ),
            SizedBox(
              height: 10,
            ),
            InfoChild(
              title: 'Kategoriyanyn ady-ru:',
              subTitle: '${category?.title_ru ?? '-'}',
            ),
            SizedBox(
              height: 10,
            ),
            InfoChild(
              title: 'Kategoriyanyn esasy kategoriasy:',
              subTitle: '${category?.parentId ?? '-'}',
            ),
            SizedBox(
              height: 10,
            ),
            InfoChild(
              title: 'Kategoriya barada-tm :',
              subTitle: '${category?.description_tm ?? '-'}',
            ),
            SizedBox(
              height: 10,
            ),
            InfoChild(
              title: 'Kategoriya barada-ru :',
              subTitle: '${category?.description_ru ?? '-'}',
            ),
          ],
          productTitle: 'Kategoriyanyn harytlary',
          products: category?.products ?? [],
          hasSubItems: true,
          subItemsTitle: 'Kategoriyanyn sub kategoriyalary',
          categorySubItems: category?.subcategories ?? [],
        );
      },
    );
  }
}
