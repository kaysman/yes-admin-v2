class CreateBrandDTO {
  final String name;
  final String logo;
  final String image;
  final bool vip; // default false

  CreateBrandDTO({
    required this.name,
    required this.logo,
    required this.image,
    required this.vip,
  });
}
