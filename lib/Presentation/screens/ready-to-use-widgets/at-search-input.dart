import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:flutter/material.dart';

class AtSearchInput extends StatefulWidget {
  AtSearchInput({Key? key}) : super(key: key);

  @override
  State<AtSearchInput> createState() => _AtSearchInputState();
}

class _AtSearchInputState extends State<AtSearchInput> {
  bool isHasAtCharacter = false;

  List<String> hasItems = ['@Dani', '@Atabek', '@Sultan', '@Aman'];
  List<String> filteredItems = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blue.shade300,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              TextField(
                onChanged: (v) {
                  var allInputValues = v.split(' ').toList();
                  var atHasValues = v
                      .split(' ')
                      .where(
                        (el) => el.startsWith('@'),
                      )
                      .toList();

                  setState(
                    () {
                      for (var val in allInputValues) {
                        isHasAtCharacter = atHasValues.contains(val);
                        if (isHasAtCharacter) {
                          filteredItems = hasItems
                              .where(
                                (el) => el
                                    .toLowerCase()
                                    .contains(val.toLowerCase()),
                              )
                              .toList();
                        }
                      }
                    },
                  );
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: 'type something...',
                ),
              ),
              if (isHasAtCharacter) ...[
                Positioned(
                  top: 50,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: kWhite,
                      border: Border.all(color: kGrey3Color),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: filteredItems
                          .map(
                            (e) => Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: kGrey3Color,
                                  ),
                                ),
                              ),
                              padding: const EdgeInsets.all(4),
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              child: Text(e.substring(1)),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ]
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Divider(
            color: kGrey3Color,
            height: 1,
            thickness: .8,
          ),
          SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
