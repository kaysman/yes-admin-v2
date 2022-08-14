import 'dart:async';

import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/theming.dart';
import 'package:flutter/material.dart';

class AtSearchInput extends StatefulWidget {
  AtSearchInput({Key? key}) : super(key: key);

  @override
  State<AtSearchInput> createState() => _AtSearchInputState();
}

class _AtSearchInputState extends State<AtSearchInput> {
  bool hasAtChar = false;
  double space = 0.0;

  final controller = TextEditingController();
  // text stream
  StreamController<String> streamController =
      StreamController<String>.broadcast();
  late StreamSubscription streamSubscription;

  // has @ stream
  StreamController<bool> streamController2 = StreamController<bool>.broadcast();

  List<String> hasItems = ['Dani', 'Atabek', 'Sultan', 'Aman'];
  List<String> filteredItems = [];

  @override
  void initState() {
    streamSubscription = streamController.stream.listen(
      (event) {
        print('---- $event ----');
        if (event == '@') {
          streamController2.add(true);
        }
      },
      onError: (e) {},
    );
    controller.addListener(() {
      final v = controller.text;
      // final isAtSymbol = v[v.length - 1];
      streamController.add(v);
      // setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    streamController.close();
    streamSubscription.cancel();
    super.dispose();
  }

  buildSuggestion() {
    return Positioned(
      top: 50,
      left: space,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: .5,
          horizontal: 3,
        ),
        decoration: BoxDecoration(
          color: kWhite,
          boxShadow: kBoxShadowLow,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: filteredItems
              .map(
                (e) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.blue.withOpacity(.2),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  child: Text(
                    e.substring(1),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width * .3;
    return Container(
      width: maxWidth,
      padding: const EdgeInsets.all(10),
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
              TextFormField(
                controller: controller,
                // onChanged: (v) {
                //   var allInputValues = v.split(' ').toList();
                //   var atHasValues = v
                //       .split(' ')
                //       .where(
                //         (el) => el.startsWith('@'),
                //       )
                //       .toList();

                //   setState(
                //     () {
                //       var _space = v.split('').length.toDouble() * 10;
                //       space = _space < maxWidth - 150 ? _space : maxWidth - 150;
                //       for (var val in allInputValues) {
                //         isHasAtCharacter = atHasValues.contains(val);
                //         if (isHasAtCharacter) {
                //           filteredItems = hasItems
                //               .where(
                //                 (el) => el.toLowerCase().contains(
                //                       val.toLowerCase(),
                //                     ),
                //               )
                //               .toList();
                //         }
                //       }
                //     },
                //   );
                // },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: 'type something...',
                  hoverColor: kWhite,
                ),
              ),
              StreamBuilder<bool>(
                initialData: false,
                stream: streamController2.stream,
                builder: (ctx, snapshot) {
                  if (snapshot.data != true) return SizedBox();
                  return buildSuggestion();
                },
              ),
            ],
          ),
          SizedBox(
            height: 4,
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
