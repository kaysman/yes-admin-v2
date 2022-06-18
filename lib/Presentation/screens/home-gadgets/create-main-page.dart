import 'package:admin_v2/Data/enums/gadget-type.dart';
import 'package:admin_v2/Presentation/screens/home-gadgets/widgets/banner-for-men-and-women.dart';
import 'package:admin_v2/Presentation/screens/home-gadgets/widgets/buttons.dart';
import 'package:admin_v2/Presentation/screens/home-gadgets/widgets/two-to-two-with-title-as-image.dart';
import 'package:admin_v2/Presentation/screens/home-gadgets/widgets/two-two-grid-title-as-text.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:flutter/material.dart';
import 'widgets/cards-16_9-horizontal-with-title-text.dart';
import 'widgets/two-small-cards.dart';

class CreateMainPage extends StatefulWidget {
  const CreateMainPage({Key? key}) : super(key: key);

  @override
  State<CreateMainPage> createState() => _CreateMainPageState();
}

class _CreateMainPageState extends State<CreateMainPage> {
  HomeGadgetType? selectedType;

  @override
  Widget build(BuildContext context) {
    double mainHaight = MediaQuery.of(context).size.height * 0.9;
    double mainWidth = MediaQuery.of(context).size.width * 0.7;
    return Container(
      height: mainHaight,
      width: mainWidth,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Sahypa döret".toUpperCase(),
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(height: 14),
            Container(
              color: kScaffoldBgColor,
              height: mainHaight * .25,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: HomeGadgetType.values.length,
                itemBuilder: (context, index) {
                  var item = HomeGadgetType.values[index];
                  var isSelected = item == selectedType;
                  return SizedBox(
                    width: 200,
                    child: Card(
                      child: ListTile(
                        tileColor:
                            isSelected ? kPrimaryColor.withOpacity(0.2) : null,
                        title: Text(item.name),
                        onTap: () {
                          setState(() {
                            selectedType = item;
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 14),
            Expanded(
              child: Container(
                width: double.infinity,
                child: () {
                  switch (selectedType) {
                    case HomeGadgetType.TWO_SMALL_CARDS_HORIZONTAL:
                      return TwoSmallCards();

                    case HomeGadgetType.BANNER_SWIPE_WITH_DOTS:
                      return Container();

                    case HomeGadgetType.TWO_TO_TWO_WITH_TITLE_AS_IMAGE:
                      return TwoToTwoWithTitleAsImage();

                    case HomeGadgetType.BANNER_FOR_MEN_AND_WOMEN:
                      return BannerForMenAndWomen();

                    case HomeGadgetType.TWO_TO_TWO_GRID_WITH_TITLE_AS_TEXT:
                      return TwoToTwoWithTitleAsText();

                    case HomeGadgetType
                        .CARDS_16_9_IN_HORIZONTAL_WITH_TITLE_AS_TEXT:
                      return Cards16_9HorizontalWithTitleText();

                    default:
                      return SizedBox();

                    // case HomeGadgetType

                    // case HomeGadgetType
                    //     .CARDS_16_9_IN_HORIZONTAL_WITH_TITLE_AS_IMAGE:

                    // case HomeGadgetType
                    //     .CARDS_2_3_IN_HORIZONTAL_WITH_TITLE_AS_IMAGE:

                    // case HomeGadgetType
                    //     .THREE_TO_THREE_GRID_WITH_TITLE_AS_TEXT:

                    // case HomeGadgetType
                    //     .CARDS_2_3_IN_HORIZONTAL_WITH_TITLE_AS_TEXT:

                    // case HomeGadgetType.POPULAR:

                    // case HomeGadgetType
                    //     .TWO_TO_THREE_PRODUCTS_IN_HORIZONTAL_WITH_TITLE_AS_TEXT:

                  }
                }(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
