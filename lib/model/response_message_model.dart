class ResponseMessageModel {
  bool? success;
  String? message;
  Map<String, dynamic>? data;
  List<dynamic>? meta;
  List<dynamic>? pagination;

  ResponseMessageModel({
    this.success,
    this.message,
    this.data,
    this.meta,
    this.pagination,
  });

  ResponseMessageModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? false;
    if (json['message'] != null) {
      message = json['message'];
    }

    if (json['data'] != null) {
      data = json['data'];
    }
  }
}
