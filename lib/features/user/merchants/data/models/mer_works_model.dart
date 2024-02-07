class MerchantsWorksModel {
  bool? success;
  int? code;
  String? message;
  List<MerchantsWorksModelData>? data;

  MerchantsWorksModel({this.success, this.code, this.message, this.data});

  MerchantsWorksModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <MerchantsWorksModelData>[];
      json['data'].forEach((v) {
        data!.add(new MerchantsWorksModelData.fromJson(v));
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

class MerchantsWorksModelData {
  int? id;
  String? file;

  MerchantsWorksModelData({this.id, this.file});

  MerchantsWorksModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['file'] = this.file;
    return data;
  }
}
