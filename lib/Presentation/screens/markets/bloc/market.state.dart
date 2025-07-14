import 'package:admin_v2/Data/models/market/market.model.dart';

enum MarketListStatus {
  idle,
  loading,
  error,
  silentLoading,
}

enum MarketCreateStatus {
  idle,
  loading,
  error,
  success,
}

enum MarketUpadteStatus {
  idle,
  loading,
  error,
  success,
}

enum MarketDeleteStatus {
  idle,
  loading,
  error,
  success,
}

enum GetMarketByIdStatus {
  idle,
  loading,
  error,
  success,
}

class MarketState {
  final List<MarketEntity>? markets;
  final MarketListStatus? listingStatus;
  final MarketCreateStatus? createStatus;
  final MarketUpadteStatus? marketUpadteStatus;
  final MarketDeleteStatus? marketDeleteStatus;
  final GetMarketByIdStatus? getMarketByIdStatus;
  final MarketEntity? selectedMarket;

  MarketState({
    this.markets,
    this.listingStatus = MarketListStatus.idle,
    this.createStatus = MarketCreateStatus.idle,
    this.marketUpadteStatus = MarketUpadteStatus.idle,
    this.marketDeleteStatus = MarketDeleteStatus.idle,
    this.getMarketByIdStatus = GetMarketByIdStatus.idle,
    this.selectedMarket,
  });

  MarketState copyWith(
      {List<MarketEntity>? markets,
      MarketListStatus? listingStatus,
      MarketCreateStatus? createStatus,
      MarketUpadteStatus? marketUpadteStatus,
      MarketDeleteStatus? marketDeleteStatus,
      GetMarketByIdStatus? getMarketByIdStatus,
      MarketEntity? selectedMarket}) {
    return MarketState(
      markets: markets ?? this.markets,
      listingStatus: listingStatus ?? this.listingStatus,
      createStatus: createStatus ?? this.createStatus,
      marketUpadteStatus: marketUpadteStatus ?? this.marketUpadteStatus,
      marketDeleteStatus: marketDeleteStatus ?? this.marketDeleteStatus,
      getMarketByIdStatus: getMarketByIdStatus ?? this.getMarketByIdStatus,
      selectedMarket: selectedMarket ?? this.selectedMarket,
    );
  }
}
