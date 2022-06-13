import 'package:admin_v2/Data/models/market/create-market.model.dart';
import 'package:admin_v2/Data/models/market/market.model.dart';
import 'package:admin_v2/Data/services/market.service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'market.state.dart';

class MarketBloc extends Cubit<MarketState> {
  MarketBloc() : super(MarketState());

  createMarket(CreateMarketDTO data) async {
    emit(state.copyWith(createStatus: MarketCreateStatus.loading));
    try {
      var res = await MarketService.createMarket(data);
      List<MarketEntity> l = List<MarketEntity>.from(state.markets ?? []);
      l.add(res!);
      emit(state.copyWith(
        markets: l,
        createStatus: MarketCreateStatus.success,
      ));
    } catch (_) {
      print(_);
      emit(state.copyWith(createStatus: MarketCreateStatus.error));
    }
  }

  getAllMarkets({String? searchQuery}) async {
    emit(state.copyWith(listingStatus: MarketListStatus.loading));
    try {
      var res;
      if (searchQuery != null) {
        print(searchQuery);
        res = await MarketService.searchMarket(searchQuery);
      } else {
        res = await MarketService.getMarkets();
      }
      emit(state.copyWith(
        markets: res,
        listingStatus: MarketListStatus.idle,
      ));
    } catch (_) {
      print(_);
      emit(state.copyWith(listingStatus: MarketListStatus.error));
    }
  }
}
