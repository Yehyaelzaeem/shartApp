class PaymentVisibilityModel {
  PaymentVisibilityModelData? data;

  PaymentVisibilityModel({this.data});

  PaymentVisibilityModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new PaymentVisibilityModelData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class PaymentVisibilityModelData {
  int? visibility;

  PaymentVisibilityModelData({this.visibility});

  PaymentVisibilityModelData.fromJson(Map<String, dynamic> json) {
    visibility = json['visibility'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['visibility'] = this.visibility;
    return data;
  }
}
