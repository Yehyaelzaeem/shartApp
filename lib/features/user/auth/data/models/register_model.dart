class RegisterModel {
  final bool? success;
  final int? code;
  final String? message;
 final RegisterData? registerData;

  RegisterModel({
     this.success, this.message, this.registerData, this.code
});

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      success: json['success'],
      message: json['message'],
      registerData: json['data'] != null ? new RegisterData.fromJson(json['data']) : null,
      code: json['code'],
    );
  }
//
}

class RegisterData{
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final PhoneCountryRegisterModel? phoneCountryRegisterModel;
  final CountryDataRegisterModel? countryDataRegisterModel;
  final CityDataRegisterModel? cityDataRegisterModel;
  final String? gender;
  final String? birth_date;
  final int? age;
  final String? image;
  final bool? is_verified;
  final String? otp;
  final String? password_otp;
  final String?type;
  final String? health_state;
  final String? health_report;
  RegisterData(
  {
     this.id,
     this.name,
     this.email,
     this.phone,
     this.phoneCountryRegisterModel,
     this.countryDataRegisterModel,
     this.cityDataRegisterModel,
     this.gender,
     this.birth_date,
     this.age,
     this.image,
     this.is_verified,
     this.otp,
     this.password_otp,
     this.type,
     this.health_state,
     this.health_report
  });

  factory RegisterData.fromJson(Map<String, dynamic> json) {
    return RegisterData(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      phoneCountryRegisterModel:json['phone_country'] != null ? new PhoneCountryRegisterModel.fromJson(json['phone_country']) : null,
      countryDataRegisterModel:json['country'] != null ? new CountryDataRegisterModel.fromJson(json['country']) : null,
      cityDataRegisterModel:json['city'] != null ? new CityDataRegisterModel.fromJson(json['city']) : null,
      gender: json['gender'],
      birth_date: json['birth_date '],
      age: json['age'],
      image: json['image'],
      is_verified: json['is_verified'],
      otp: json['otp'],
      password_otp: json['password_otp'],
      type: json['type'],
      health_state: json['health_state'],
      health_report: json['health_report'],
    );
  }

}



class PhoneCountryRegisterModel {
  final int? id;
  final String? name;
  final String? phone;
  final String? image;

  PhoneCountryRegisterModel({ this.id, this.name, this.phone, this.image});

  factory PhoneCountryRegisterModel.fromJson(Map<String, dynamic> json) {
    return PhoneCountryRegisterModel(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      image: json['image'],
    );
  }
//
}

class CountryDataRegisterModel{
  final int? id;
  final String? name;
  final String? phone_code;
  final String? image;

  CountryDataRegisterModel({this.id, this.name, this.phone_code, this.image});

  factory CountryDataRegisterModel.fromJson(Map<String, dynamic> json) {
    return CountryDataRegisterModel(
      id: json['id'],
      name: json['name'],
      phone_code: json['phone_code'],
      image: json['image'],
    );
  }
//
}

class CityDataRegisterModel{
  final int? id;
  final String? name;

  CityDataRegisterModel({this.id, this.name});

  factory CityDataRegisterModel.fromJson(Map<String, dynamic> json) {
    return CityDataRegisterModel(
      id: json['id'],
      name: json['name'],
    );
  }
//
}