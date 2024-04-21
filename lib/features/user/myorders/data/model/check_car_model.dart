class GetCheckCarsModel {
  bool? success;
  int? code;
  String? message;
  List<GetCheckCarsModelData>? data;

  GetCheckCarsModel({this.success, this.code, this.message, this.data});

  GetCheckCarsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GetCheckCarsModelData>[];
      json['data'].forEach((v) {
        data!.add(new GetCheckCarsModelData.fromJson(v));
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

class GetCheckCarsModelData {
  int? id;
  Car? car;
  Package? package;
  String? description;
  String? status;
  String? createdAt;
  String? file;

  GetCheckCarsModelData({this.id, this.car, this.package, this.description, this.status ,this.file});

  GetCheckCarsModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    car = json['car'] != null ? new Car.fromJson(json['car']) : null;
    package =
    json['package'] != null ? new Package.fromJson(json['package']) : null;
    description = json['description'];
    status = json['status'];
    file = json['file'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.car != null) {
      data['car'] = this.car!.toJson();
    }
    if (this.package != null) {
      data['package'] = this.package!.toJson();
    }
    data['description'] = this.description;
    data['status'] = this.status;
    data['file'] = this.file;
    return data;
  }
}

class Car {
  int? id;
  Brand? brand;
  Modal? modal;
  ColorModel? color;
  String? chassisNo;
  String? year;

  Car({this.id, this.brand, this.modal, this.color, this.chassisNo, this.year});

  Car.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brand = json['brand'] != null ? new Brand.fromJson(json['brand']) : null;
    modal = json['modal'] != null ? new Modal.fromJson(json['modal']) : null;
    color = json['color'] != null ? new ColorModel.fromJson(json['color']) : null;
    chassisNo = json['chassis_no'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.brand != null) {
      data['brand'] = this.brand!.toJson();
    }
    if (this.modal != null) {
      data['modal'] = this.modal!.toJson();
    }
    if (this.color != null) {
      data['color'] = this.color!.toJson();
    }
    data['chassis_no'] = this.chassisNo;
    data['year'] = this.year;
    return data;
  }
}

class Brand {
  int? id;
  String? name;
  String? image;
  String? type;

  Brand({this.id, this.name, this.image, this.type});

  Brand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['type'] = this.type;
    return data;
  }
}

class Modal {
  int? id;
  String? name;
  int? isActive;

  Modal({this.id, this.name, this.isActive});

  Modal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['is_active'] = this.isActive;
    return data;
  }
}

class ColorModel {
  int? id;
  String? name;
  String? color;

  ColorModel({this.id, this.name, this.color});

  ColorModel.fromJson(Map<String, dynamic> json) {
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

class Package {
  int? id;
  String? title;
  List<String>? features;
  int? price;
  String? image;

  Package({this.id, this.title, this.features, this.price, this.image});

  Package.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    features = json['features'].cast<String>();
    price = json['price'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['features'] = this.features;
    data['price'] = this.price;
    data['image'] = this.image;
    return data;
  }
}
