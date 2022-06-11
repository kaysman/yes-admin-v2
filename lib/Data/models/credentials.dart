class Credentials {
  String? accessToken;
  String? refreshToken;
  // final DateTime expirationDate;
  final int? expiresIn;
  Credentials({this.accessToken, this.refreshToken, this.expiresIn});

  Credentials.fromJson(Map<String, dynamic> json)
      : accessToken = json["access_token"],
        refreshToken = json["refresh_token"],
        expiresIn = json["expires_in"];

  Credentials.fromStore(Map<String, dynamic> json)
      : accessToken = json["access_token"],
        refreshToken = json["refresh_token"],
        expiresIn = json["expires_in"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['refresh_token'] = this.refreshToken;
    data['expires_in'] = this.expiresIn;
    return data;
  }
}
