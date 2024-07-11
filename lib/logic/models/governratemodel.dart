class governrateModel {
  // final String id;
  final String image;
  final String name;
  final String id;

  governrateModel({required this.image, required this.name, required this.id});

  factory governrateModel.fromJson(Map<String, dynamic> json) {
    return governrateModel(
      id: json['_id'] ?? '',
      image: json['image'] ?? '',
      name: json['name'] ?? '',
    );
  }
}
