class BrandModel {
  bool? success;
  int? code;
  String? message;
  List<BrandModelData>? data;

  BrandModel({this.success, this.code, this.message, this.data});

  BrandModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <BrandModelData>[];
      json['data'].forEach((v) {data!.add(BrandModelData.fromJson(v));
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

class BrandModelData {
  int? id;
  String? name;
  int? brandId;

  BrandModelData({this.id, this.name, this.brandId});

  BrandModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    brandId = json['brand_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['brand_id'] = this.brandId;
    return data;
  }
}
