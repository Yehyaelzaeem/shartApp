class BrandColors {
  bool? success;
  int? code;
  String? message;
  List<BrandColorsData>? data;

  BrandColors({this.success, this.code, this.message, this.data});

  BrandColors.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <BrandColorsData>[];
      json['data'].forEach((v) {
        data!.add(new BrandColorsData.fromJson(v));
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

class BrandColorsData {
  int? id;
  String? name;
  String? color;

  BrandColorsData({this.id, this.name, this.color});

  BrandColorsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['color'] = this.color;
    return data;
  }
}
