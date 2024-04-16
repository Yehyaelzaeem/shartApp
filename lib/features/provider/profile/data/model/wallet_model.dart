class WalletModel {
  bool? success;
  int? code;
  String? message;
  WalletModelData? data;

  WalletModel({this.success, this.code, this.message, this.data});

  WalletModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new WalletModelData.fromJson(json['data']) : null;
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

class WalletModelData {
  dynamic totalWallets;
  dynamic unpaidWallets;
  dynamic paidWallets;
  List<Wallets>? wallets;

  WalletModelData({this.totalWallets, this.unpaidWallets, this.paidWallets, this.wallets});

  WalletModelData.fromJson(Map<String, dynamic> json) {
    totalWallets = json['total_wallets'];
    unpaidWallets = json['unpaid_wallets'];
    paidWallets = json['paid_wallets'];
    if (json['wallets'] != null) {
      wallets = <Wallets>[];
      json['wallets'].forEach((v) {
        wallets!.add(new Wallets.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_wallets'] = this.totalWallets;
    data['unpaid_wallets'] = this.unpaidWallets;
    data['paid_wallets'] = this.paidWallets;
    if (this.wallets != null) {
      data['wallets'] = this.wallets!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Wallets {
  int? id;
  int? orderId;
  int? percent;
  dynamic amount;
  String? status;
  String? date;

  Wallets(
      {this.id,
        this.orderId,
        this.percent,
        this.amount,
        this.status,
        this.date});

  Wallets.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    percent = json['percent'];
    amount = json['amount'];
    status = json['status'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['percent'] = this.percent;
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['date'] = this.date;
    return data;
  }
}
