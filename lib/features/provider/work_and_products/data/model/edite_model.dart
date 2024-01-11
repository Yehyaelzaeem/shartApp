class EditProductModel {
  bool? success;
  int? code;
  String? message;
  Data? data;

  EditProductModel({this.success, this.code, this.message, this.data});

  EditProductModel.fromJson(Map<String, dynamic> json) {
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
  String? title;
  String? productStatus;
  String? description;
  String? price;
  String? type;
  Brand? brand;
  String? brandId;
  String? modal;
  String? modalId;
  Provider? provider;
  String? providerId;
  List<Images>? images;

  Data(
      {this.id,
        this.title,
        this.productStatus,
        this.description,
        this.price,
        this.type,
        this.brand,
        this.brandId,
        this.modal,
        this.modalId,
        this.provider,
        this.providerId,
        this.images});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    productStatus = json['product_status'];
    description = json['description'];
    price = json['price'];
    type = json['type'];
    brand = json['brand'] != null ? new Brand.fromJson(json['brand']) : null;
    brandId = json['brand_id'];
    modal = json['modal'];
    modalId = json['modal_id'];
    provider = json['provider'] != null
        ? new Provider.fromJson(json['provider'])
        : null;
    providerId = json['provider_id'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['product_status'] = this.productStatus;
    data['description'] = this.description;
    data['price'] = this.price;
    data['type'] = this.type;
    if (this.brand != null) {
      data['brand'] = this.brand!.toJson();
    }
    data['brand_id'] = this.brandId;
    data['modal'] = this.modal;
    data['modal_id'] = this.modalId;
    if (this.provider != null) {
      data['provider'] = this.provider!.toJson();
    }
    data['provider_id'] = this.providerId;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Brand {
  int? id;
  String? name;
  String? image;

  Brand({this.id, this.name, this.image});

  Brand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}

class Provider {
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
  String? age;
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

  Provider(
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
        this.rate});

  Provider.fromJson(Map<String, dynamic> json) {
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

class Images {
  int? id;
  int? providerProductId;
  String? image;
  String? createdAt;
  String? updatedAt;

  Images(
      {this.id,
        this.providerProductId,
        this.image,
        this.createdAt,
        this.updatedAt});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    providerProductId = json['provider_product_id'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['provider_product_id'] = this.providerProductId;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
