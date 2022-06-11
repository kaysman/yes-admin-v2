class ErrorLog {
  final DateTime? errorDate;
  final String? category;
  final String? location;
  final int? userId;
  final int? teamId;
  final String? params;
  final String? message;
  final String? details;

  ErrorLog({
    this.errorDate,
    this.category,
    this.location,
    this.userId,
    this.teamId,
    this.params,
    this.message,
    this.details,
  });

  ErrorLog.fromJson(Map<String, dynamic> json)
      : errorDate = json["errorDate"] == null
            ? null
            : DateTime.parse(json["errorDate"]),
        category = json["category"],
        location = json["location"],
        userId = json['userId'],
        teamId = json['teamId'],
        params = json['params'],
        message = json['message'],
        details = json['details'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = Map<String, dynamic>();
    json['errorDate'] = this.errorDate.toString();
    json['category'] = this.category;
    json['location'] = this.location;
    json['userId'] = this.userId;
    json['teamId'] = this.teamId;
    json['params'] = this.params;
    json['message'] = this.message;
    json['details'] = this.details;
    return json;
  }
}
