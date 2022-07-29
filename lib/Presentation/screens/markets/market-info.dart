import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/components/button.dart';
import 'package:admin_v2/Presentation/shared/components/view-info.dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/market.bloc.dart';
import 'bloc/market.state.dart';

class MarketInfo extends StatefulWidget {
  const MarketInfo({Key? key, required this.selectedMarketId})
      : super(key: key);
  final int? selectedMarketId;
  @override
  State<MarketInfo> createState() => _MarketInfoState();
}

class _MarketInfoState extends State<MarketInfo> {
  late MarketBloc marketBloc;

  @override
  void initState() {
    super.initState();
    marketBloc = BlocProvider.of<MarketBloc>(context);
    if (widget.selectedMarketId != null) {
      marketBloc.getMarketById(widget.selectedMarketId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MarketBloc, MarketState>(
      listenWhen: (s1, s2) => s1.selectedMarket != s2.selectedMarket,
      listener: (context, state) {},
      builder: (context, state) {
        if (state.getMarketByIdStatus == GetMarketByIdStatus.loading) {
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
        if (state.getMarketByIdStatus == GetMarketByIdStatus.error) {
          return SizedBox(
            width: MediaQuery.of(context).size.width * .3,
            height: MediaQuery.of(context).size.width * .3,
            child: Center(
              child: TryAgainButton(
                tryAgain: () async {
                  if (widget.selectedMarketId != null) {
                    await marketBloc.getMarketById(widget.selectedMarketId!);
                  }
                },
              ),
            ),
          );
        }
        var market = state.selectedMarket;
        return ViewInfoDialog(
          infoTitle: 'Market barada',
          infoChildren: [
            InfoChild(title: 'Market ady :', subTitle: '${market?.title}'),
            SizedBox(
              height: 10,
            ),
            InfoChild(
                title: 'Market address :', subTitle: '${market?.address}'),
            SizedBox(
              height: 10,
            ),
            InfoChild(
                title: 'Market telefon :', subTitle: '${market?.phoneNumber}'),
            SizedBox(
              height: 10,
            ),
            InfoChild(
                title: 'Market eyesi :', subTitle: '${market?.ownerName}'),
            SizedBox(
              height: 10,
            ),
            InfoChild(
                title: 'Market barada :', subTitle: '${market?.description}'),
          ],
          productTitle: 'Market harytlary',
          products: market?.products ?? [],
        );
      },
    );
  }
}
