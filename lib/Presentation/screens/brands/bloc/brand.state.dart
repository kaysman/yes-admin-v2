import 'package:admin_v2/Data/models/brand/brand.model.dart';
import 'package:equatable/equatable.dart';

enum BrandListStatus { idle, loading, error, silentLoading }

enum BrandCreateStatus { idle, loading, error, success }

enum BrandUpdateStatus { idle, loading, error, success }

enum BrandDeleteStatus { idle, loading, error, success }

enum GetBrandByIdStatus { idle, loading, error, success }

class BrandState {
  final List<BrandEntity>? brands;
  final BrandListStatus? listingStatus;
  final BrandCreateStatus? createStatus;
  final BrandUpdateStatus? brandUpdateStatus;
  final BrandDeleteStatus? brandDeleteStatus;
  final GetBrandByIdStatus? getBrandByIdStatus;
  final BrandEntity? selectedBrand;

  BrandState(
      {this.brands,
      this.listingStatus = BrandListStatus.idle,
      this.createStatus = BrandCreateStatus.idle,
      this.brandUpdateStatus = BrandUpdateStatus.idle,
      this.brandDeleteStatus = BrandDeleteStatus.idle,
      this.getBrandByIdStatus = GetBrandByIdStatus.idle,
      this.selectedBrand});

  BrandState copyWith({
    List<BrandEntity>? brands,
    BrandListStatus? listingStatus,
    BrandCreateStatus? createStatus,
    BrandUpdateStatus? brandUpdateStatus,
    BrandDeleteStatus? brandDeleteStatus,
    GetBrandByIdStatus? getBrandByIdStatus,
    BrandEntity? selectedBrand,
  }) {
    return BrandState(
      brands: brands ?? this.brands,
      listingStatus: listingStatus ?? this.listingStatus,
      createStatus: createStatus ?? this.createStatus,
      brandUpdateStatus: brandUpdateStatus ?? this.brandUpdateStatus,
      brandDeleteStatus: brandDeleteStatus ?? this.brandDeleteStatus,
      getBrandByIdStatus: getBrandByIdStatus ?? this.getBrandByIdStatus,
      selectedBrand: selectedBrand ?? this.selectedBrand,
    );
  }
}
