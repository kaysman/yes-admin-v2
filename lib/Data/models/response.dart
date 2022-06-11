class ApiResponse<T> {
  final bool? success;
  final T? data;
  final dynamic links;
  final dynamic messages;
  final List<ApiError>? errors;

  ApiResponse(
      {this.success, this.data, this.links, this.messages, this.errors});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      success: json["success"],
      data: json["data"],
      links: json["links"],
      messages: json["messages"],
      errors: (json["errors"] != null)
          ? List<ApiError>.from(json["errors"].map((x) => ApiError.fromJson(x)))
          : [],
    );
  }
}

class ApiError {
  final dynamic code;
  final String? description;
  ApiError({this.code, this.description});

  factory ApiError.fromJson(Map<String, dynamic> json) {
    return ApiError(code: json["code"], description: json["description"]);
  }
}
