import 'package:admin_v2/Data/models/market/market.model.dart';

enum MarketListStatus { idle, loading, error , silentLoading}

enum MarketCreateStatus { idle, loading, error, success }

class MarketState {
  final List<MarketEntity>? markets;
  final MarketListStatus? listingStatus;
  final MarketCreateStatus? createStatus;

  MarketState({
    this.markets,
    this.listingStatus = MarketListStatus.idle,
    this.createStatus = MarketCreateStatus.idle,
  });

  MarketState copyWith({
    List<MarketEntity>? markets,
    MarketListStatus? listingStatus,
    MarketCreateStatus? createStatus,
  }) {
    return MarketState(
      markets: markets ?? this.markets,
      listingStatus: listingStatus ?? this.listingStatus,
      createStatus: createStatus ?? this.createStatus,
    );
  }
}
