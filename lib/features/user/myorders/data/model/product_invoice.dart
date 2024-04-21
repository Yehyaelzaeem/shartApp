class Product {
  Product({required this.name,required this.description,required this.price,required this.quantity,required this.total});

  final String name;
  final String description;
  final String quantity;
  final String price;
  final String total;
}
class CheckCar{
  final String ago;
  final String fromTime;
  final String toTime;
  final String name;
  final String price;

  CheckCar({required this.ago,required this.fromTime,required this.toTime,required this.name,required this.price});
}