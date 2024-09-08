class PaymentModel {
  final String paymentId;
  final String tranId;
  final String eci;
  final String result;
  final String trackId;
  final String authCode;
  final String responseCode;
  final String rrn;
  final String responseHash;
  final String cardBrand;
  final dynamic amount;
  final String? userField1;
  final String? userField3;
  final String? userField4;
  final String? userField5;
  final String? cardToken;
  final String maskedPAN;
  final String? email;
  final String? payFor;
  final String? subscriptionId;
  final String paymentType;
  final String? metaData;

  PaymentModel({
    required this.paymentId,
    required this.tranId,
    required this.eci,
    required this.result,
    required this.trackId,
    required this.authCode,
    required this.responseCode,
    required this.rrn,
    required this.responseHash,
    required this.cardBrand,
    required this.amount,
    this.userField1,
    this.userField3,
    this.userField4,
    this.userField5,
    this.cardToken,
    required this.maskedPAN,
    this.email,
    this.payFor,
    this.subscriptionId,
    required this.paymentType,
    this.metaData,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      paymentId: json['PaymentId'],
      tranId: json['TranId'],
      eci: json['ECI'],
      result: json['Result'],
      trackId: json['TrackId'],
      authCode: json['AuthCode'],
      responseCode: json['ResponseCode'],
      rrn: json['RRN'],
      responseHash: json['responseHash'],
      cardBrand: json['cardBrand'],
      amount: json['amount'],
      userField1: json['UserField1'],
      userField3: json['UserField3'],
      userField4: json['UserField4'],
      userField5: json['UserField5'],
      cardToken: json['cardToken'],
      maskedPAN: json['maskedPAN'],
      email: json['email'],
      payFor: json['payFor'],
      subscriptionId: json['SubscriptionId'],
      paymentType: json['PaymentType'],
      metaData: json['metaData'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'PaymentId': paymentId,
      'TranId': tranId,
      'ECI': eci,
      'Result': result,
      'TrackId': trackId,
      'AuthCode': authCode,
      'ResponseCode': responseCode,
      'RRN': rrn,
      'responseHash': responseHash,
      'cardBrand': cardBrand,
      'amount': amount,
      'UserField1': userField1,
      'UserField3': userField3,
      'UserField4': userField4,
      'UserField5': userField5,
      'cardToken': cardToken,
      'maskedPAN': maskedPAN,
      'email': email,
      'payFor': payFor,
      'SubscriptionId': subscriptionId,
      'PaymentType': paymentType,
      'metaData': metaData,
    };
  }
}
