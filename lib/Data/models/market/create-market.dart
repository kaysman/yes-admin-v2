class CreateMarketDTO {
  final String title;
  final String? logo;
  final String? address;
  final String? description;
  final String phoneNumber;
  final String? ownerName;

  CreateMarketDTO({
    required this.title,
    this.logo,
    this.address,
    this.description,
    required this.phoneNumber,
    this.ownerName,
  });
}
