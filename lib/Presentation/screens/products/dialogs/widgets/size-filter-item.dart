import 'package:admin_v2/Data/models/filter/filter.entity.model.dart';
import 'package:admin_v2/Data/models/product/size.model.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:fluent_ui/fluent_ui.dart';
// import 'package:flutter/material.dart';

class SizefilterItem extends StatefulWidget {
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
  State<SizefilterItem> createState() => _SizefilterItemState();
}

class _SizefilterItemState extends State<SizefilterItem> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _controller.text = '1';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
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
            widget.itemForUpdate == null
                ? widget.item?.name_tm ?? '-'
                : widget.itemForUpdate?.name_tm ?? '-',
          ),
          SizedBox(
            width: 5,
          ),
          SizedBox(
            width: 50,
            child: TextBox(
              controller: _controller,
              onChanged: widget.onChangeCount,
              foregroundDecoration: BoxDecoration(
                border: Border.all(
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: this.widget.onCLear,
            icon: Icon(FluentIcons.remove),
          ),
        ],
      ),
    );
  }
}
