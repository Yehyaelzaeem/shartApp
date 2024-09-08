class MySuppliesModel {
  bool? success;
  int? code;
  String? message;
  List<MySuppliesModelData>? data;

  MySuppliesModel({this.success, this.code, this.message, this.data});

  MySuppliesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <MySuppliesModelData>[];
      json['data'].forEach((v) {
        data!.add(new MySuppliesModelData.fromJson(v));
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

class MySuppliesModelData {
  int? id;
  int? userId;
  int? supplyPackageId;
  int? totalPrice;
  String? paymentStatus;
  String? paymentMethod;
  String? note;
  User? user;
  SuppliesPackage? suppliesPackage;

  MySuppliesModelData(
      {this.id,
        this.userId,
        this.supplyPackageId,
        this.totalPrice,
        this.paymentStatus,
        this.paymentMethod,
        this.note,
        this.user,
        this.suppliesPackage});

  MySuppliesModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    supplyPackageId = json['supply_package_id'];
    totalPrice = json['total_price'];
    paymentStatus = json['payment_status'];
    paymentMethod = json['payment_method'];
    note = json['note'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    suppliesPackage = json['supplies_package'] != null
        ? new SuppliesPackage.fromJson(json['supplies_package'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['supply_package_id'] = this.supplyPackageId;
    data['total_price'] = this.totalPrice;
    data['payment_status'] = this.paymentStatus;
    data['payment_method'] = this.paymentMethod;
    data['note'] = this.note;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.suppliesPackage != null) {
      data['supplies_package'] = this.suppliesPackage!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  PhoneCountry? phoneCountry;
  PhoneCountry? country;
  City? city;
  String? gender;
  String? birthDate;
  int? age;
  String? image;
  bool? isVerified;
  String? otp;
  String? passwordOtp;
  String? type;
  String? fcmToken;
  String? healthState;
  String? healthReport;
  Car? car;

  User(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.phoneCountry,
        this.country,
        this.city,
        this.gender,
        this.birthDate,
        this.age,
        this.image,
        this.isVerified,
        this.otp,
        this.passwordOtp,
        this.type,
        this.fcmToken,
        this.healthState,
        this.healthReport,
        this.car});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    phoneCountry = json['phone_country'] != null
        ? new PhoneCountry.fromJson(json['phone_country'])
        : null;
    country = json['country'] != null
        ? new PhoneCountry.fromJson(json['country'])
        : null;
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    gender = json['gender'];
    birthDate = json['birth_date'];
    age = json['age'];
    image = json['image'];
    isVerified = json['is_verified'];
    otp = json['otp'];
    passwordOtp = json['password_otp'];
    type = json['type'];
    fcmToken = json['fcm_token'];
    healthState = json['health_state'];
    healthReport = json['health_report'];
    car = json['car'] != null ? new Car.fromJson(json['car']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    if (this.phoneCountry != null) {
      data['phone_country'] = this.phoneCountry!.toJson();
    }
    if (this.country != null) {
      data['country'] = this.country!.toJson();
    }
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    data['gender'] = this.gender;
    data['birth_date'] = this.birthDate;
    data['age'] = this.age;
    data['image'] = this.image;
    data['is_verified'] = this.isVerified;
    data['otp'] = this.otp;
    data['password_otp'] = this.passwordOtp;
    data['type'] = this.type;
    data['fcm_token'] = this.fcmToken;
    data['health_state'] = this.healthState;
    data['health_report'] = this.healthReport;
    if (this.car != null) {
      data['car'] = this.car!.toJson();
    }
    return data;
  }
}

class PhoneCountry {
  int? id;
  String? name;
  String? phoneCode;
  Null? image;

  PhoneCountry({this.id, this.name, this.phoneCode, this.image});

  PhoneCountry.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phoneCode = json['phone_code'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone_code'] = this.phoneCode;
    data['image'] = this.image;
    return data;
  }
}

class City {
  int? id;
  String? name;

  City({this.id, this.name});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
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

class SuppliesPackage {
  int? id;
  String? name;
  String? description;
  String? image;
  String? duration;
  int? price;
  String? createdAt;

  SuppliesPackage(
      {this.id,
        this.name,
        this.description,
        this.image,
        this.duration,
        this.price,
        this.createdAt});

  SuppliesPackage.fromJson(Map<String, dynamic> json) {
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
