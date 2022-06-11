class UserIdentity {
  final String? name;
  final int? userID;

  UserIdentity({this.name, this.userID});

  factory UserIdentity.fromJson(Map<String, dynamic> json) {
    return UserIdentity(
      name: json["name"],
      userID: json["userID"],
    );
  }
}

// isAdmin =
class UserProfile {
  final int? userId;
  final int? externalUserId;
  final String? name;
  final String? email;
  final String? title;
  final String? avatar;
  final bool? isAdmin;
  final bool? isOwner;
  final bool? isClient;
  UserProfile(
      {this.userId,
      this.externalUserId,
      this.name,
      this.email,
      this.title,
      this.avatar,
      this.isAdmin,
      this.isOwner,
      this.isClient});

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
        userId: json["userID"],
        externalUserId: json["externalUserID"],
        name: json["name"],
        email: json["email"],
        title: json["title"],
        avatar: json["avatar"],
        isAdmin: json["isAdmin"],
        isOwner: json["isOwner"],
        isClient: json["isClient"]);
  }
}

class UserSetting {
  String? constantName;
  dynamic settingDetails;
  UserSetting({this.constantName, this.settingDetails});

  factory UserSetting.fromJson(Map<String, dynamic> json) {
    return UserSetting(
        constantName: json["constantName"],
        settingDetails: json["settingDetails"]);
  }
}
