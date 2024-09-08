class SuppliesModel {
  bool? success;
  int? code;
  String? message;
  List<SuppliesModelData>? data;

  SuppliesModel({this.success, this.code, this.message, this.data});

  SuppliesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SuppliesModelData>[];
      json['data'].forEach((v) {
        data!.add(new SuppliesModelData.fromJson(v));
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

class SuppliesModelData {
  int? id;
  String? name;
  String? description;
  String? image;
  String? duration;
  int? price;
  String? createdAt;

  SuppliesModelData(
      {this.id,
        this.name,
        this.description,
        this.image,
        this.duration,
        this.price,
        this.createdAt});

  SuppliesModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    duration = json['duration'];
    price = json['price'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    data['duration'] = this.duration;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    return data;
  }
}
