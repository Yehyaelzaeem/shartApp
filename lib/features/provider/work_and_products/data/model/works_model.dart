class WorksModel {
  bool? success;
  int? code;
  String? message;
  List<WorksModelData>? data;

  WorksModel({this.success, this.code, this.message, this.data});

  WorksModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <WorksModelData>[];
      json['data'].forEach((v) {
        data!.add(new WorksModelData.fromJson(v));
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

class WorksModelData {
  int? id;
  String? file;

  WorksModelData({this.id, this.file});

  WorksModelData.fromJson(Map<String, dynamic> json) {
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
