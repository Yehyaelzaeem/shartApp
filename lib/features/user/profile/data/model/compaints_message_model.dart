class ComplaintMessageModel {
  bool? success;
  int? code;
  String? message;
  ComplaintMessageModelData? data;

  ComplaintMessageModel({this.success, this.code, this.message, this.data});

  ComplaintMessageModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new ComplaintMessageModelData.fromJson(json['data']) : null;
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

class ComplaintMessageModelData {
  String? name;
  String? email;
  String? phone;
  String? message;
  String? type;
  String? messageType;
  String? updatedAt;
  String? createdAt;
  int? id;

  ComplaintMessageModelData(
      {this.name,
        this.email,
        this.phone,
        this.message,
        this.type,
        this.messageType,
        this.updatedAt,
        this.createdAt,
        this.id});

  ComplaintMessageModelData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    message = json['message'];
    type = json['type'];
    messageType = json['message_type'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['message'] = this.message;
    data['type'] = this.type;
    data['message_type'] = this.messageType;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
