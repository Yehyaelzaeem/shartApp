class ProductPushDataModel{
  final String? type;
  final String? title;
  final String? brandId;
  final String? modelId;
  final String? width;
  final String? height;
  final String? size;
  final String? state;
  final String? description;
  final String? price;

  ProductPushDataModel(
  {
    this.type,
    this.title,
    this.brandId,
    this.modelId,
    this.width,
    this.height,
    this.size,
    this.state,
    this.description,
    this.price
});

  Map<String, dynamic> toJson() {
    return {
      "type": this.type,
      "title": this.title,
      "brandId": this.brandId,
      "modelId": this.modelId,
      "width": this.width,
      "height": this.height,
      "size": this.size,
      "state": this.state,
      "description": this.description,
      "price": this.price,
    };
  }
}