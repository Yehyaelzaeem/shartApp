class CartItems {
  List<Items>? items;
  int? userAddressId;
  String? note;

  CartItems({this.items, this.userAddressId, this.note});

  CartItems.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    userAddressId = json['user_address_id'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['user_address_id'] = this.userAddressId;
    data['note'] = this.note;
    return data;
  }
}

class Items {
  int? providerProductId;
  int? qty;
  int? providerId;

  Items({this.providerProductId, this.qty, this.providerId});

  Items.fromJson(Map<String, dynamic> json) {
    providerProductId = json['provider_product_id'];
    qty = json['qty'];
    providerId = json['provider_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['provider_product_id'] = this.providerProductId;
    data['qty'] = this.qty;
    data['provider_id'] = this.providerId;
    return data;
  }
}
