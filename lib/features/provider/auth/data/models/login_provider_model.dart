class LoginProviderModel {
  bool? success;
  int? code;
  String? message;
  LoginProviderModelData? data;

  LoginProviderModel({this.success, this.code, this.message, this.data});

  LoginProviderModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new LoginProviderModelData.fromJson(json['data']) : null;
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

class LoginProviderModelData {
  int? id;
  String? name;
  String? email;
  String? phone;
  PhoneCountry? phoneCountry;
  String? image;
  String? storeName;
  String? commercialRegistrationNo;
  String? ipan;
  String? commercialEndDate;
  String? mainAddress;
  String? commercialRegistrationFile;
  String? logo;
  String? nationalIdImage;
  String? status;
  String? suspensionReason;
  bool? profileCompleted;
  bool? isVerified;
  String? otp;
  String? passwordOtp;
  String? type;
  int? rate;
  String? accessToken;

  LoginProviderModelData(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.phoneCountry,
        this.image,
        this.storeName,
        this.commercialRegistrationNo,
        this.ipan,
        this.commercialEndDate,
        this.mainAddress,
        this.commercialRegistrationFile,
        this.logo,
        this.nationalIdImage,
        this.status,
        this.suspensionReason,
        this.profileCompleted,
        this.isVerified,
        this.otp,
        this.passwordOtp,
        this.type,
        this.rate,
        this.accessToken});

  LoginProviderModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    phoneCountry = json['phone_country'] != null
        ? new PhoneCountry.fromJson(json['phone_country'])
        : null;
    image = json['image'];
    storeName = json['store_name'];
    commercialRegistrationNo = json['commercial_registration_no'];
    ipan = json['ipan'];
    commercialEndDate = json['commercial_end_date'];
    mainAddress = json['main_address'];
    commercialRegistrationFile = json['commercial_registration_file'];
    logo = json['logo'];
    nationalIdImage = json['national_id_image'];
    status = json['status'];
    suspensionReason = json['suspension_reason'];
    profileCompleted = json['profile_completed'];
    isVerified = json['is_verified'];
    otp = json['otp'];
    passwordOtp = json['password_otp'];
    type = json['type'];
    rate = json['rate'];
    accessToken = json['access_token'];
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
    data['image'] = this.image;
    data['store_name'] = this.storeName;
    data['commercial_registration_no'] = this.commercialRegistrationNo;
    data['ipan'] = this.ipan;
    data['commercial_end_date'] = this.commercialEndDate;
    data['main_address'] = this.mainAddress;
    data['commercial_registration_file'] = this.commercialRegistrationFile;
    data['logo'] = this.logo;
    data['national_id_image'] = this.nationalIdImage;
    data['status'] = this.status;
    data['suspension_reason'] = this.suspensionReason;
    data['profile_completed'] = this.profileCompleted;
    data['is_verified'] = this.isVerified;
    data['otp'] = this.otp;
    data['password_otp'] = this.passwordOtp;
    data['type'] = this.type;
    data['rate'] = this.rate;
    data['access_token'] = this.accessToken;
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
