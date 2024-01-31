class PackagesModel {
  bool? success;
  int? code;
  String? message;
  List<PackagesModelData>? data;

  PackagesModel({this.success, this.code, this.message, this.data});

  PackagesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PackagesModelData>[];
      json['data'].forEach((v) {
        data!.add(new PackagesModelData.fromJson(v));
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

class PackagesModelData {
  int? id;
  String? title;
  List<String>? description;
  String? period;
  int? price;

  PackagesModelData({this.id, this.title, this.description, this.period, this.price});

  PackagesModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'].cast<String>();
    period = json['period'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['period'] = this.period;
    data['price'] = this.price;
    return data;
  }
}
