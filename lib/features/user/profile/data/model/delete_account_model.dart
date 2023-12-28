class DeleteAccountModel {
  bool? success;
  int? code;
  String? message;
  String? data;

  DeleteAccountModel({this.success, this.code, this.message, this.data});

  DeleteAccountModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['code'] = this.code;
    data['message'] = this.message;
    data['data'] = this.data;
    return data;
  }
}
