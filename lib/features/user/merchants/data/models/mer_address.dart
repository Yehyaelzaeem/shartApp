class MerchantsAddressModel {
  bool? success;
  int? code;
  String? message;
  List<MerchantsAddressModelData>? data;

  MerchantsAddressModel({this.success, this.code, this.message, this.data});

  MerchantsAddressModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <MerchantsAddressModelData>[];
      json['data'].forEach((v) {
        data!.add(new MerchantsAddressModelData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MerchantsAddressModelData {
  int? id;
  String? name;
  String? address;
  String? lat;
  String? lng;
  String? phone;
  String? note;
  int? userId;

  MerchantsAddressModelData(
      {this.id,
        this.name,
        this.address,
        this.lat,
        this.lng,
        this.phone,
        this.note,
        this.userId});

  MerchantsAddressModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    lat = json['lat'];
    lng = json['lng'];
    phone = json['phone'];
    note = json['note'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['phone'] = this.phone;
    data['note'] = this.note;
    data['user_id'] = this.userId;
    return data;
  }
}
