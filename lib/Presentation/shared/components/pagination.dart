import 'package:admin_v2/Data/models/meta.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:fluent_ui/fluent_ui.dart';
// import 'package:flutter/material.dart';

class Pagination extends StatelessWidget {
  const Pagination({
    Key? key,
    this.metaData,
    required this.text,
    this.goPrevious,
    required this.goNext,
  }) : super(key: key);

  final Meta? metaData;
  final Function? goPrevious;
  final Function? goNext;
  final String text;

  // Future<void> fetchPage(/*Meta?*/ meta, [toPrevious = false]) async {
  //   if (meta != null) {
  //     if (toPrevious && meta.hasPrevious)
  //       this.goPrevious();
  //     else if (meta.hasNext) this.goNext();
  //   }
  //   return;
  // }

  @override
  Widget build(BuildContext context) {
    var _meta = metaData;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          SizedBox(
              width: double.infinity,
              child: Divider(
                style: DividerThemeData(
                    decoration: BoxDecoration(
                  color: kGrey4Color,
                )),
              )
              // Divider(
              //   style: DividerThemeData(decoration: ),
              //     // indent: 0,
              //     // endIndent: 0,
              //     ),
              ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (this.goPrevious != null)
                IconButton(
                  style: ButtonStyle(
                      backgroundColor: ButtonState.all(kGrey4Color)),
                  icon: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        FluentIcons.back,
                        size: 14,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Previous',
                        style:
                            FluentTheme.of(context).typography.body?.copyWith(
                                  fontSize: 16,
                                ),
                      ),
                    ],
                  ),
                  onPressed: () => this.goNext,
                ),
              SizedBox(width: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: kGrey3Color),
                  borderRadius: BorderRadius.circular(8),
                ),
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.all(
                //     const Radius.circular(6),
                //   ),
                // ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: Text(
                    // "${_meta?.currentPage}",,
                    text,
                    style: FluentTheme.of(context).typography.bodyLarge,
                  ),
                ),
              ),
              // if (_meta?.totalPages != null) SizedBox(width: 8),
              // if (_meta?.totalPages != null)
              //   Text(
              //     "out of ${_meta?.totalPages}",
              //     style: Theme.of(context).textTheme.headline4,
              //   ),
              SizedBox(width: 16),
              if (this.goNext != null)
                IconButton(
                  style: ButtonStyle(
                      backgroundColor: ButtonState.all(kGrey4Color)),
                  icon: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Next',
                        style:
                            FluentTheme.of(context).typography.body?.copyWith(
                                  fontSize: 16,
                                ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Icon(
                        FluentIcons.forward,
                        size: 14,
                      ),
                    ],
                  ),
                  onPressed: () => this.goNext,
                ),
              // GestureDetector(
              //   onTap: () => this.goNext!.call(),
              //   child: Row(
              //     children: [
              //       Text(
              //         "Next",
              //         style: FluentTheme.of(context).typography.bodyLarge,
              //       ),
              //       SizedBox(width: 8),
              //       Icon(
              //         FluentIcons.forward,
              //         // color: kPrimaryColor,
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
