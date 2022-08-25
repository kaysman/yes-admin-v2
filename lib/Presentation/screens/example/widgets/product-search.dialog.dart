import 'package:admin_v2/Data/models/product/product.model.dart';
import 'package:admin_v2/Presentation/screens/example/widgets/custom-auto-suggested-box.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:admin_v2/Presentation/shared/components/button.dart' as f;

class ProductSearch extends StatelessWidget {
  const ProductSearch(
      {Key? key,
      required this.onChanged,
      required this.onSearch,
      this.products,
      required this.isSearching})
      : super(key: key);
  final ValueChanged<String?> onChanged;
  final VoidCallback onSearch;
  final List<ProductEntity>? products;
  final bool isSearching;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomAutoSuggestedBox(
            hintText: 'e.g: T-shirt',
            items: products?.map((e) => e.name_tm ?? '-').toList() ?? [],
            onChanged: onChanged,
            label: 'Haryt gozle',
            isEditMode: true,
          ),
          SizedBox(
            height: 14,
          ),
          f.Button(
            textColor: kWhite,
            primary: kswPrimaryColor,
            isLoading: isSearching,
            text: 'Gozle',
            onPressed: onSearch,
          )
        ],
      ),
    );
  }
}
