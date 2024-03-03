class ResetPasswordModel {
  bool? success;
  int? code;
  String? message;
  ResetPasswordModelData? data;

  ResetPasswordModel({this.success, this.code, this.message, this.data});

  ResetPasswordModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new ResetPasswordModelData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ResetPasswordModelData {
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

  ResetPasswordModelData(
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

  ResetPasswordModelData.fromJson(Map<String, dynamic> json) {
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
  String? image;

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
  Color? color;
  String? chassisNo;
  String? year;

  Car({this.id, this.brand, this.modal, this.color, this.chassisNo, this.year});

  Car.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brand = json['brand'] != null ? new Brand.fromJson(json['brand']) : null;
    modal = json['modal'] != null ? new Modal.fromJson(json['modal']) : null;
    color = json['color'] != null ? new Color.fromJson(json['color']) : null;
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

class Color {
  int? id;
  String? name;
  String? color;

  Color({this.id, this.name, this.color});

  Color.fromJson(Map<String, dynamic> json) {
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
