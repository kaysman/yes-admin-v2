import 'package:admin_v2/Data/models/filter/filter.entity.model.dart';
import 'package:admin_v2/Data/models/product/size.model.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'package:flutter/material.dart';

class SizefilterItem extends StatelessWidget {
  const SizefilterItem({
    Key? key,
    this.item,
    required this.onChangeCount,
    required this.onCLear,
    this.itemForUpdate,
  }) : super(key: key);

  final SizeEntity? itemForUpdate;
  final FilterEntity? item;
  final ValueChanged<String?> onChangeCount;
  final VoidCallback onCLear;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: kswPrimaryColor.withOpacity(.2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 10,
          ),
          Text(
            itemForUpdate == null
                ? item?.name_tm ?? '-'
                : itemForUpdate?.name_tm ?? '-',
          ),
          SizedBox(
            width: 5,
          ),
          SizedBox(
            height: 28,
            width: 50,
            child: TextFormField(
              initialValue: '1',
              onChanged: onChangeCount,
              decoration: InputDecoration(
                hintText: '1',
                border: kEnabledInputBorder,
                enabledBorder: kEnabledInputBorder,
                focusedBorder: kFocusedInputBorder,
                errorBorder: kErrorInputBorder,
              ),
            ),
          ),
          IconButton(
            onPressed: this.onCLear,
            splashRadius: 5,
            icon: Icon(Icons.close),
            iconSize: 14,
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}
