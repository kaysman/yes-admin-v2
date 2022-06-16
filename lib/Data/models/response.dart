class ApiResponse<T> {
  final bool? success;
  final T? data;
  final dynamic links;
  final dynamic message;

  ApiResponse({this.success, this.data, this.links, this.message});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      success: json["success"],
      data: json["data"],
      links: json["links"],
      message: json["message"],
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
