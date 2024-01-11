class GetProductsModel {
  bool? success;
  int? code;
  String? message;
  List<GetProductsModelData>? data;

  GetProductsModel({this.success, this.code, this.message, this.data});

  GetProductsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GetProductsModelData>[];
      json['data'].forEach((v) {
        data!.add(new GetProductsModelData.fromJson(v));
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

class GetProductsModelData {
  int? id;
  String? title;
  String? productStatus;
  String? description;
  int? price;
  String? type;
  int? width;
  int? height;
  String? size;
  Provider? provider;
  String? providerId;
  List<Images>? images;
  Brand? brand;
  int? brandId;
  String? modal;
  int? modalId;

  GetProductsModelData(
      {this.id,
        this.title,
        this.productStatus,
        this.description,
        this.price,
        this.type,
        this.width,
        this.height,
        this.size,
        this.provider,
        this.providerId,
        this.images,
        this.brand,
        this.brandId,
        this.modal,
        this.modalId});

  GetProductsModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    productStatus = json['product_status'];
    description = json['description'];
    price = json['price'];
    type = json['type'];
    width = json['width'];
    height = json['height'];
    size = json['size'];
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
    brand = json['brand'] != null ? new Brand.fromJson(json['brand']) : null;
    brandId = json['brand_id'];
    modal = json['modal'];
    modalId = json['modal_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['product_status'] = this.productStatus;
    data['description'] = this.description;
    data['price'] = this.price;
    data['type'] = this.type;
    data['width'] = this.width;
    data['height'] = this.height;
    data['size'] = this.size;
    if (this.provider != null) {
      data['provider'] = this.provider!.toJson();
    }
    data['provider_id'] = this.providerId;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    if (this.brand != null) {
      data['brand'] = this.brand!.toJson();
    }
    data['brand_id'] = this.brandId;
    data['modal'] = this.modal;
    data['modal_id'] = this.modalId;
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

  Provider(
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
