class AboutCompanyModel {
  bool? success;
  int? code;
  String? message;
  AboutCompanyModelData? data;

  AboutCompanyModel({this.success, this.code, this.message, this.data});

  AboutCompanyModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new AboutCompanyModelData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class AboutCompanyModelData {
  String? name;
  String? content;

  AboutCompanyModelData({this.name, this.content});

  AboutCompanyModelData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['content'] = this.content;
    return data;
  }
}
