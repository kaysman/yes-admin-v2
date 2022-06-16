import 'package:admin_v2/Data/models/brand/brand.model.dart';

enum BrandListStatus { idle, loading, error, silentLoading }

enum BrandCreateStatus { idle, loading, error, success }

class BrandState {
  final List<BrandEntity>? brands;
  final BrandListStatus? listingStatus;
  final BrandCreateStatus? createStatus;

  BrandState({
    this.brands,
    this.listingStatus = BrandListStatus.idle,
    this.createStatus = BrandCreateStatus.idle,
  });

  BrandState copyWith({
    List<BrandEntity>? brands,
    BrandListStatus? listingStatus,
    BrandCreateStatus? createStatus,
  }) {
    return BrandState(
      brands: brands ?? this.brands,
      listingStatus: listingStatus ?? this.listingStatus,
      createStatus: createStatus ?? this.createStatus,
    );
  }
}
