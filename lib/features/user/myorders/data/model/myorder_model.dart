class MyOrdersModel {
  bool? success;
  int? code;
  String? message;
  List<MyOrdersModelData>? data;

  MyOrdersModel({this.success, this.code, this.message, this.data});

  MyOrdersModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <MyOrdersModelData>[];
      json['data'].forEach((v) {
        data!.add(new MyOrdersModelData.fromJson(v));
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

class MyOrdersModelData {
   int? id;
   int? providerId;
   Provider? provider;
   int? userId;
   User? user;
  dynamic totalPrice;
   String? status;
   String? userNote;
   String? adminNote;
   String? providerNote;
  List<Items>? items;

  MyOrdersModelData(
      {this.id,
        this.providerId,
        this.provider,
        this.userId,
        this.user,
        this.totalPrice,
        this.status,
        this.userNote,
        this.adminNote,
        this.providerNote,
        this.items});

  MyOrdersModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    providerId = json['provider_id'];
    provider = json['provider'] != null
        ? new Provider.fromJson(json['provider'])
        : null;
    userId = json['user_id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    totalPrice = json['total_price'];
    status = json['status'];
    userNote = json['user_note'];
    adminNote = json['admin_note'];
    providerNote = json['provider_note'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['provider_id'] = this.providerId;
    if (this.provider != null) {
      data['provider'] = this.provider!.toJson();
    }
    data['user_id'] = this.userId;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['total_price'] = this.totalPrice;
    data['status'] = this.status;
    data['user_note'] = this.userNote;
    data['admin_note'] = this.adminNote;
    data['provider_note'] = this.providerNote;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
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
  int? otp;
  String? passwordOtp;
  String? type;
  CurrentSubscription? currentSubscription;
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
        this.currentSubscription,
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
    currentSubscription = json['current_subscription'] != null
        ? new   CurrentSubscription.fromJson(json['current_subscription'])
        : null;
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
    if (this.currentSubscription != null) {
      data['current_subscription'] = this.currentSubscription!.toJson();
    }
    data['rate'] = this.rate;
    return data;
  }
}
class CurrentSubscription {
  int? id;
  int? providerId;
  int? subscriptionId;
  Subscription? subscription;
  String? startsAt;
  String? endsAt;
  String? status;
  String? paymentMethod;
  String? paymentStatus;
  String? paymentId;
  int? adminId;

  CurrentSubscription(
      {this.id,
        this.providerId,
        this.subscriptionId,
        this.subscription,
        this.startsAt,
        this.endsAt,
        this.status,
        this.paymentMethod,
        this.paymentStatus,
        this.paymentId,
        this.adminId});

  CurrentSubscription.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    providerId = json['provider_id'];
    subscriptionId = json['subscription_id'];
    subscription = json['subscription'] != null
        ? new Subscription.fromJson(json['subscription'])
        : null;
    startsAt = json['starts_at'];
    endsAt = json['ends_at'];
    status = json['status'];
    paymentMethod = json['payment_method'];
    paymentStatus = json['payment_status'];
    paymentId = json['payment_id'];
    adminId = json['admin_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['provider_id'] = this.providerId;
    data['subscription_id'] = this.subscriptionId;
    if (this.subscription != null) {
      data['subscription'] = this.subscription!.toJson();
    }
    data['starts_at'] = this.startsAt;
    data['ends_at'] = this.endsAt;
    data['status'] = this.status;
    data['payment_method'] = this.paymentMethod;
    data['payment_status'] = this.paymentStatus;
    data['payment_id'] = this.paymentId;
    data['admin_id'] = this.adminId;
    return data;
  }
}
class Subscription {
  int? id;
  String? title;
  List<String>? description;
  String? period;
  int? price;

  Subscription(
      {this.id, this.title, this.description, this.period, this.price});

  Subscription.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'].cast<String>();
    period = json['period'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['period'] = this.period;
    data['price'] = this.price;
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
  int? otp;
  String? passwordOtp;
  String? type;
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
    healthState = json['health_state'];
    healthReport = json['health_report'];
    car =  json['car'] != null
        ? new Car.fromJson(json['car'])
        : null;
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
    if (this.car != null) {
      data['car'] = this.car!.toJson();
    }
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

class Items {
  int? id;
  int? orderId;
  int? providerId;
  Provider? provider;
  int? providerProductId;
  ProviderProduct? providerProduct;
  dynamic price;
  int? qty;

  Items(
      {this.id,
        this.orderId,
        this.providerId,
        this.provider,
        this.providerProductId,
        this.providerProduct,
        this.price,
        this.qty});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    providerId = json['provider_id'];
    provider = json['provider'] != null
        ? new Provider.fromJson(json['provider'])
        : null;
    providerProductId = json['provider_product_id'];
    providerProduct = json['provider_product'] != null
        ? new ProviderProduct.fromJson(json['provider_product'])
        : null;
    price = json['price'];
    qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['provider_id'] = this.providerId;
    if (this.provider != null) {
      data['provider'] = this.provider!.toJson();
    }
    data['provider_product_id'] = this.providerProductId;
    if (this.providerProduct != null) {
      data['provider_product'] = this.providerProduct!.toJson();
    }
    data['price'] = this.price;
    data['qty'] = this.qty;
    return data;
  }
}

// class Provider {
//   int? id;
//   String? name;
//   String? email;
//   String? phone;
//   PhoneCountry? phoneCountry;
//   String? image;
//   String? storeName;
//   String? commercialRegistrationNo;
//   String? ipan;
//   String? commercialEndDate;
//   String? mainAddress;
//   String? commercialRegistrationFile;
//   String? logo;
//   String? nationalIdImage;
//   String? status;
//   String? suspensionReason;
//   bool? profileCompleted;
//   bool? isVerified;
//   String? otp;
//   String? passwordOtp;
//   String? type;
//   String? currentSubscription;
//   int? rate;
//
//   Provider(
//       {this.id,
//         this.name,
//         this.email,
//         this.phone,
//         this.phoneCountry,
//         this.image,
//         this.storeName,
//         this.commercialRegistrationNo,
//         this.ipan,
//         this.commercialEndDate,
//         this.mainAddress,
//         this.commercialRegistrationFile,
//         this.logo,
//         this.nationalIdImage,
//         this.status,
//         this.suspensionReason,
//         this.profileCompleted,
//         this.isVerified,
//         this.otp,
//         this.passwordOtp,
//         this.type,
//         this.currentSubscription,
//         this.rate});
//
//   Provider.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     email = json['email'];
//     phone = json['phone'];
//     phoneCountry = json['phone_country'] != null
//         ? new PhoneCountry.fromJson(json['phone_country'])
//         : null;
//     image = json['image'];
//     storeName = json['store_name'];
//     commercialRegistrationNo = json['commercial_registration_no'];
//     ipan = json['ipan'];
//     commercialEndDate = json['commercial_end_date'];
//     mainAddress = json['main_address'];
//     commercialRegistrationFile = json['commercial_registration_file'];
//     logo = json['logo'];
//     nationalIdImage = json['national_id_image'];
//     status = json['status'];
//     suspensionReason = json['suspension_reason'];
//     profileCompleted = json['profile_completed'];
//     isVerified = json['is_verified'];
//     otp = json['otp'];
//     passwordOtp = json['password_otp'];
//     type = json['type'];
//     currentSubscription = json['current_subscription'];
//     rate = json['rate'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['email'] = this.email;
//     data['phone'] = this.phone;
//     if (this.phoneCountry != null) {
//       data['phone_country'] = this.phoneCountry!.toJson();
//     }
//     data['image'] = this.image;
//     data['store_name'] = this.storeName;
//     data['commercial_registration_no'] = this.commercialRegistrationNo;
//     data['ipan'] = this.ipan;
//     data['commercial_end_date'] = this.commercialEndDate;
//     data['main_address'] = this.mainAddress;
//     data['commercial_registration_file'] = this.commercialRegistrationFile;
//     data['logo'] = this.logo;
//     data['national_id_image'] = this.nationalIdImage;
//     data['status'] = this.status;
//     data['suspension_reason'] = this.suspensionReason;
//     data['profile_completed'] = this.profileCompleted;
//     data['is_verified'] = this.isVerified;
//     data['otp'] = this.otp;
//     data['password_otp'] = this.passwordOtp;
//     data['type'] = this.type;
//     data['current_subscription'] = this.currentSubscription;
//     data['rate'] = this.rate;
//     return data;
//   }
// }
class WidthModel {
  int? id;
  String? name;

  WidthModel({this.id, this.name});

  WidthModel.fromJson(Map<String, dynamic> json) {
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
class HeightModel {
  int? id;
  String? name;

  HeightModel({this.id, this.name});

  HeightModel.fromJson(Map<String, dynamic> json) {
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
class SizeModelProduct {
  int? id;
  String? name;

  SizeModelProduct({this.id, this.name});

  SizeModelProduct.fromJson(Map<String, dynamic> json) {
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

class ProviderProduct {
  int? id;
  String? title;
  String? productStatus;
  String? description;
  dynamic price;
  String? type;
  Brand? brand;
  int? brandId;
  Model? modal;
  int? modalId;
  Provider? provider;
  String? providerId;
  List<Images>? images;
  bool? isFav;
  WidthModel? width;
  HeightModel? height;
  SizeModelProduct? size;

  ProviderProduct(
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
        this.images,
        this.isFav,
        this.width,
        this.height,
        this.size});

  ProviderProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    productStatus = json['product_status'];
    description = json['description'];
    price = json['price'];
    type = json['type'];
    brand = json['brand'] != null ? new Brand.fromJson(json['brand']) : null;
    brandId = json['brand_id'];
    modal = json['modal'] != null ? new Model.fromJson(json['modal']) : null;
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
    isFav = json['is_fav'];
    width =json['width'] != null ? new WidthModel.fromJson(json['width']) : null;
    height = json['height'] != null ? new HeightModel.fromJson(json['height']) : null;
    size = json['size'] != null ? new SizeModelProduct.fromJson(json['size']) : null;
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
    if (this.modal != null) {
      data['modal'] = this.modal!.toJson();
    }
    data['brand_id'] = this.brandId;
    data['modal_id'] = this.modalId;
    if (this.provider != null) {
      data['provider'] = this.provider!.toJson();
    }
    data['provider_id'] = this.providerId;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['is_fav'] = this.isFav;
    if (this.width != null) {
      data['width'] = this.width!.toJson();
    } if (this.height != null) {
      data['height'] = this.height!.toJson();
    } if (this.size != null) {
      data['size'] = this.size!.toJson();
    }
    return data;
  }
}
class Model {
  int? id;
  String? name;

  Model({this.id, this.name});

  Model.fromJson(Map<String, dynamic> json) {
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
