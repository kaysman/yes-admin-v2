import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/components/button.dart';
import 'package:admin_v2/Presentation/shared/theming.dart';
import 'package:flutter/material.dart';

class MultiSelectDropdown extends StatefulWidget {
  MultiSelectDropdown({Key? key}) : super(key: key);

  @override
  State<MultiSelectDropdown> createState() => _MultiSelectDropdownState();
}

class _MultiSelectDropdownState extends State<MultiSelectDropdown> {
  List<String> items = [
    'Mens wear',
    'Perfumes',
    'Women\'s wear',
    'Mens wear other',
    'Perfumes other',
    'Women\'s wear other',
  ];

  List<String> selectedItems = [];

  bool isHover = false;
  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * .5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Multiselect Field'),
          SizedBox(
            height: 8,
          ),
          Column(
            children: [
              InkWell(
                hoverColor: Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  setState(() {
                    isShow = !isShow;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: kGrey4Color,
                    ),
                    color: kGrey5Color.withOpacity(.2),
                  ),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: selectedItems
                              .map(
                                (e) => Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: kWhite,
                                    boxShadow: kBoxShadowLow,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(e),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        child: Container(
                                          padding: const EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                            color: kGrey1Color,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.close,
                                            size: 10,
                                            color: kWhite,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      Icon(
                        Icons.arrow_drop_up_rounded,
                        color: kGrey1Color,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 14,
              ),
              AnimatedCrossFade(
                firstChild: MultiSelectItems(
                  items: items,
                  onSave: (List<String> value) {
                    setState(() {
                      selectedItems = value;
                      isShow = !isShow;
                    });
                  },
                ),
                secondChild: SizedBox(),
                crossFadeState: isShow
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: Duration(
                  milliseconds: 300,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class MultiSelectItems extends StatefulWidget {
  MultiSelectItems({
    Key? key,
    required this.items,
    required this.onSave,
  }) : super(key: key);

  final List<String> items;
  final ValueChanged<List<String>> onSave;

  @override
  State<MultiSelectItems> createState() => _MultiSelectItemsState();
}

class _MultiSelectItemsState extends State<MultiSelectItems> {
  List<String> selectedItems = [];

  bool isAdded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * .3),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        boxShadow: kBoxShadowLow,
        color: kWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: ListView(
                children: List.generate(widget.items.length, (index) {
                  var item = widget.items[index];
                  return InkWell(
                    onHover: (v) {},
                    hoverColor: kGrey3Color,
                    onTap: () {
                      setState(() {
                        if (!selectedItems.contains(item)) {
                          selectedItems.add(item);
                        } else {
                          selectedItems.remove(item);
                        }
                      });
                    },
                    child: Container(
                      color: selectedItems.contains(item) ? kGrey3Color : null,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(item),
                          Checkbox(
                            value: selectedItems.contains(item),
                            onChanged: (v) {},
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Button(
                  text: 'OK',
                  onPressed: () {
                    widget.onSave.call(selectedItems);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// class ArrowUpAndDown extends StatelessWidget {
//   const ArrowUpAndDown({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         
//         Icon(
//           color: kGrey1Color,
//           Icons.arrow_drop_down_rounded,
//         ),
//       ],
//     );
//   }
// }
