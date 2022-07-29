import 'package:admin_v2/Data/models/product/image.model.dart';
import 'package:admin_v2/Data/models/product/size.model.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:flutter/material.dart';

class ProductViewInfoDialog extends StatelessWidget {
  ProductViewInfoDialog({
    super.key,
    required this.infoChildren,
    required this.infoTitle,
    required this.sizeTitle,
    required this.sizes,
    required this.images,
    this.imageTitle,
  });

  final List<Widget> infoChildren;
  final String infoTitle;
  final String sizeTitle;
  final List<SizeEntity> sizes;
  final List<ImageEntity> images;
  final String? imageTitle;

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
                children: [TextSpan(text: ' : jemi ${images.length} sany')],
              ),
            ),
            childrenPadding: const EdgeInsets.only(top: 20, bottom: 10),
            children: [
              GridView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  // childAspectRatio: 2.5,
                ),
                children: List.generate(
                  images.isEmpty ? 1 : images.length,
                  (i) {
                    if (images.isEmpty) {
                      return Text(
                        'surat yok...',
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              fontSize: 24,
                              color: kGrey2Color,
                            ),
                      );
                    }
                    var image = images[i].getFullPathImage;
                    return image != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              image,
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * .5,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * .5,
                            color: kswPrimaryColor,
                          );
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
