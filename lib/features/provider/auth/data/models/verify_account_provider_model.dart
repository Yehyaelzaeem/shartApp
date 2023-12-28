class VerifyAccountProviderModel {
  bool? success;
  int? code;
  String? message;
  Data? data;

  VerifyAccountProviderModel(
      {this.success, this.code, this.message, this.data});

  VerifyAccountProviderModel.fromJson(Map<String, dynamic> json) {
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
  String? image;
  String? degree;
  String? experienceYears;
  String? gender;
  String? nationality;
  String? department;
  String? category;
  String? subCategory;
  String? foundation;
  String? foundationName;
  String? birthDate;
  int? age;
  String? scientificCertificate;
  String? nationalIdFront;
  String? nationalIdBack;
  String? passport;
  String? residence;
  String? signedContract;
  String? status;
  String? suspensionReason;
  bool? profileCompleted;
  bool? isVerified;
  String? otp;
  String? passwordOtp;
  String? type;
  String? languages;
  String? description;
  int? isRecommended;
  List<String>? providerDays;
  int? overNight;
  int? rate;
  String? accessToken;

  Data(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.phoneCountry,
        this.image,
        this.degree,
        this.experienceYears,
        this.gender,
        this.nationality,
        this.department,
        this.category,
        this.subCategory,
        this.foundation,
        this.foundationName,
        this.birthDate,
        this.age,
        this.scientificCertificate,
        this.nationalIdFront,
        this.nationalIdBack,
        this.passport,
        this.residence,
        this.signedContract,
        this.status,
        this.suspensionReason,
        this.profileCompleted,
        this.isVerified,
        this.otp,
        this.passwordOtp,
        this.type,
        this.languages,
        this.description,
        this.isRecommended,
        this.providerDays,
        this.overNight,
        this.rate,
        this.accessToken});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    phoneCountry = json['phone_country'] != null
        ? new PhoneCountry.fromJson(json['phone_country'])
        : null;
    image = json['image'];
    degree = json['degree'];
    experienceYears = json['experience_years'];
    gender = json['gender'];
    nationality = json['nationality'];
    department = json['department'];
    category = json['category'];
    subCategory = json['sub_category'];
    foundation = json['foundation'];
    foundationName = json['foundation_name'];
    birthDate = json['birth_date'];
    age = json['age'];
    scientificCertificate = json['scientific_certificate'];
    nationalIdFront = json['national_id_front'];
    nationalIdBack = json['national_id_back'];
    passport = json['passport'];
    residence = json['residence'];
    signedContract = json['signed_contract'];
    status = json['status'];
    suspensionReason = json['suspension_reason'];
    profileCompleted = json['profile_completed'];
    isVerified = json['is_verified'];
    otp = json['otp'];
    passwordOtp = json['password_otp'];
    type = json['type'];
    languages = json['languages'];
    description = json['description'];
    isRecommended = json['is_recommended'];
    providerDays = json['provider_days'].cast<String>();
    overNight = json['over_night'];
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
    data['degree'] = this.degree;
    data['experience_years'] = this.experienceYears;
    data['gender'] = this.gender;
    data['nationality'] = this.nationality;
    data['department'] = this.department;
    data['category'] = this.category;
    data['sub_category'] = this.subCategory;
    data['foundation'] = this.foundation;
    data['foundation_name'] = this.foundationName;
    data['birth_date'] = this.birthDate;
    data['age'] = this.age;
    data['scientific_certificate'] = this.scientificCertificate;
    data['national_id_front'] = this.nationalIdFront;
    data['national_id_back'] = this.nationalIdBack;
    data['passport'] = this.passport;
    data['residence'] = this.residence;
    data['signed_contract'] = this.signedContract;
    data['status'] = this.status;
    data['suspension_reason'] = this.suspensionReason;
    data['profile_completed'] = this.profileCompleted;
    data['is_verified'] = this.isVerified;
    data['otp'] = this.otp;
    data['password_otp'] = this.passwordOtp;
    data['type'] = this.type;
    data['languages'] = this.languages;
    data['description'] = this.description;
    data['is_recommended'] = this.isRecommended;
    data['provider_days'] = this.providerDays;
    data['over_night'] = this.overNight;
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
