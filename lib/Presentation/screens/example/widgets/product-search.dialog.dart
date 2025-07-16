import 'package:admin_v2/Data/models/product/product.model.dart';
import 'package:admin_v2/Presentation/screens/example/widgets/custom-auto-suggested-box.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:flutter/material.dart';

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
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              backgroundColor: Theme.of(context).colorScheme.primary,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: onSearch,
            child: const Text('Gozle'),
          )
        ],
      ),
    );
  }
}
