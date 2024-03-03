
class Cart {
  final int? id;
  final String? productId;
  final String? productName;
  final dynamic productPrice;
  final String? description;
  final String? image;
  final String? type;
  final String? productState;
  final String? providerId;
  final String? productBrand;
  final bool? isFav;
  int? count;


  Cart({
    required this.id,
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.description,
    required this.image,
    required this.type,
    this.isFav,
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
      productPrice: double.parse(json['productPrice']),
      description: json['description'],
      image: json['image'],
      type: json['type'],
      isFav: json['isFav'],
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
      'isFav': this.isFav,
      'providerId': this.providerId,
      'productBrand': this.productBrand,
      'count': this.count,
    };
  }
}