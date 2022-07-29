import 'package:admin_v2/Data/models/gadget/image.model.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:flutter/material.dart';

class GadgetViewInfoDialog extends StatelessWidget {
  GadgetViewInfoDialog({
    super.key,
    required this.infoChildren,
    required this.infoTitle,
    required this.imageTitle,
    required this.items,
  });

  final List<Widget> infoChildren;
  final String infoTitle;
  final String imageTitle;
  final List<GadgetImage> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      width: MediaQuery.of(context).size.width * .4,
      child: ListView(
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.close),
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Text(
            infoTitle,
            style:
                Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 24),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: infoChildren,
          ),
          SizedBox(
            height: 24,
          ),
          ExpansionTile(
            tilePadding: EdgeInsets.zero,
            title: Text.rich(
              TextSpan(
                text: imageTitle,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(fontSize: 24),
                children: [TextSpan(text: ' : jemi ${items.length} sany')],
              ),
            ),
            childrenPadding: const EdgeInsets.only(top: 20, bottom: 10),
            children: [
              GridView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                ),
                children: List.generate(
                  items.isEmpty ? 1 : items.length,
                  (i) {
                    if (items.isEmpty) {
                      return Text(
                        'surat yok...',
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              fontSize: 24,
                              color: kGrey2Color,
                            ),
                      );
                    }
                    var item = items[i];
                    print(item.getFullPathImage);
                    return Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: kGrey5Color),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          item.getFullPathImage != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    item.getFullPathImage!,
                                    width: double.infinity,
                                    height: MediaQuery.of(context).size.height /
                                        3.5,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Container(
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height / 3.5,
                                  color: kswPrimaryColor,
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${item.link ?? '-'}',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

// class InfoChild extends StatelessWidget {
//   const InfoChild({
//     Key? key,
//     required this.title,
//     required this.subTitle,
//   }) : super(key: key);
//   final String title;
//   final String subTitle;
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           title,
//           style: Theme.of(context).textTheme.bodyText2?.copyWith(
//                 fontSize: 20,
//                 color: kGrey1Color,
//               ),
//         ),
//         Text(
//           subTitle,
//           style: Theme.of(context)
//               .textTheme
//               .bodyText1
//               ?.copyWith(fontSize: 20, color: kGrey1Color),
//         ),
//       ],
//     );
//   }
// }
