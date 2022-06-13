import 'package:admin_v2/Data/models/market/market.model.dart';

enum MarketListStatus { idle, loading, error }

enum MarketCreateStatus { idle, loading, error, success }

class ProductState {
  final List<MarketEntity>? markets;
  final MarketListStatus? listingStatus;
  final MarketCreateStatus? createStatus;

  ProductState({
    this.markets,
    this.listingStatus = MarketListStatus.idle,
    this.createStatus = MarketCreateStatus.idle,
  });

  ProductState copyWith({
    List<MarketEntity>? markets,
    MarketListStatus? listingStatus,
    MarketCreateStatus? createStatus,
  }) {
    return ProductState(
      markets: markets ?? this.markets,
      listingStatus: listingStatus ?? this.listingStatus,
      createStatus: createStatus ?? this.createStatus,
    );
  }
}
