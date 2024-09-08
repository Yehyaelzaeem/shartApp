class CheckCarModel{
  final String? packageId;
  final String? brandId;
  final String? modelId;
  final String? colorId;
  final String? year;
  final String? chassis_no;
  final String? description;

  CheckCarModel(
      {this.packageId,
      this.brandId,
      this.modelId,
      this.colorId,
      this.year,
      this.chassis_no,
      this.description});

  Map<String, dynamic> toJson() {
    return {
      "package_id": this.packageId,
      "brand": this.brandId,
      "modal": this.modelId,
      "color": this.colorId,
      "year": this.year,
      "chassis_no": this.chassis_no,
      "description": this.description,
    };
  }
}