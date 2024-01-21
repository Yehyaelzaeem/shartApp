
class Cart {
  final int? id;
  final String? productId;
  final String? productName;
  final int? productPrice;
  final String? description;
  final String? image;
  final String? type;
  final String? productState;
  final String? providerId;
  final String? productBrand;
  int? count;


  Cart({
    required this.id,
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.description,
    required this.image,
    required this.type,
    required this.productState,
    required this.providerId,
    required this.productBrand,
    required this.count
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: int.parse(json['id']),
      productId: json['productId'],
      productName: json['productName'],
      productPrice: int.parse(json['productPrice']),
      description: json['description'],
      image: json['image'],
      type: json['type'],
      productState: json['productState'],
      providerId: json['providerId'],
      count: json['count'],
      productBrand: json['productBrand'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'productId': this.productId,
      'productName': this.productName,
      'productPrice': this.productPrice,
      'description': this.description,
      'image': this.image,
      'type': this.type,
      'productState': this.productState,
      'providerId': this.providerId,
      'productBrand': this.productBrand,
      'count': this.count,
    };
  }
}