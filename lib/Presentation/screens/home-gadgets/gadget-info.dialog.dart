import 'package:admin_v2/Presentation/screens/home-gadgets/bloc/gadget.bloc.dart';
import 'package:admin_v2/Presentation/screens/home-gadgets/widgets/gadget-view-info.dialog.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/components/button.dart';
import 'package:admin_v2/Presentation/shared/components/status-indicator.widget.dart';
import 'package:admin_v2/Presentation/shared/components/view-info.dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GadgetInfo extends StatefulWidget {
  const GadgetInfo({
    Key? key,
    required this.selectedGadgetId,
  }) : super(key: key);
  final int? selectedGadgetId;
  @override
  State<GadgetInfo> createState() => _GadgetInfoState();
}

class _GadgetInfoState extends State<GadgetInfo> {
  late GadgetBloc gadgetBloc;

  @override
  void initState() {
    super.initState();
    gadgetBloc = BlocProvider.of<GadgetBloc>(context);
    if (widget.selectedGadgetId != null) {
      gadgetBloc.getGadgetById(widget.selectedGadgetId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GadgetBloc, GadgetState>(
      listenWhen: (s1, s2) => s1.gadget != s2.gadget,
      listener: (context, state) {},
      builder: (context, state) {
        if (state.getGadgetByIdStatus == GetGadgetByIdStatus.loading) {
          return SizedBox(
            width: MediaQuery.of(context).size.width * .3,
            height: MediaQuery.of(context).size.width * .3,
            child: Center(
              child: CircularProgressIndicator(
                color: kswPrimaryColor,
              ),
            ),
          );
        }
        if (state.getGadgetByIdStatus == GetGadgetByIdStatus.error) {
          return SizedBox(
            width: MediaQuery.of(context).size.width * .3,
            height: MediaQuery.of(context).size.width * .3,
            child: Center(
              child: TryAgainButton(
                tryAgain: () async {
                  if (widget.selectedGadgetId != null) {
                    await gadgetBloc.getGadgetById(widget.selectedGadgetId!);
                  }
                },
              ),
            ),
          );
        }
        var gadget = state.gadget;
        return GadgetViewInfoDialog(
          infoTitle: 'Gadget barada',
          infoChildren: [
            InfoChild(
                title: 'Gadget ady :', subTitle: '${gadget?.title ?? '-'}'),
            SizedBox(
              height: 10,
            ),
            InfoChild(
                title: 'Gadgetin tertibi :',
                subTitle: '${gadget?.queue ?? '-'}'),
            SizedBox(
              height: 10,
            ),
            InfoChild(
                title: 'Gadgetin gornusi :',
                subTitle: '${gadget?.type ?? '-'}'),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Gadget status',
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        fontSize: 20,
                        color: kGrey1Color,
                      ),
                ),
                StatusIndicator(
                  isInfo: true,
                  color: gadget?.status == "ACTIVE"
                      ? kswPrimaryColor
                      : Colors.redAccent.withOpacity(.8),
                  label: "${gadget?.status ?? '-'}",
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            InfoChild(
                title: 'Gadget yerlesyan yeri :',
                subTitle: '${gadget?.location ?? '-'}'),
          ],
          imageTitle: 'Gadget suratlary',
          items: gadget?.items ?? [],
        );
      },
    );
  }
}
