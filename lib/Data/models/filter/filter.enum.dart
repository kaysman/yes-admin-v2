enum FilterType {
  SIZE,
  GENDER,
  COLOR,
}

extension AddOns on FilterType {
  String get readableText {
    switch (this) {
      case FilterType.SIZE:
        return "Ölçeg";

      case FilterType.GENDER:
        return "Jynsy";

      case FilterType.COLOR:
        return "Reňki";

      default:
        return "Belli dal";
    }
  }
}
