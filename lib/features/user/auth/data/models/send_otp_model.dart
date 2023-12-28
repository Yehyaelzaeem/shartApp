class SendOTPModel {
  bool? success;
  int? code;
  String? message;
  Data? data;

  SendOTPModel({this.success, this.code, this.message, this.data});

  SendOTPModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
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
  String? healthState;
  String? healthReport;

  Data(
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
        this.healthState,
        this.healthReport});

  Data.fromJson(Map<String, dynamic> json) {
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
    healthState = json['health_state'];
    healthReport = json['health_report'];
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
    data['health_state'] = this.healthState;
    data['health_report'] = this.healthReport;
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
