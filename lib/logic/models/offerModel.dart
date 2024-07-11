class OfferModel {
  final String id;
  final String title;
  final String description;
  final int quantity;
  final double price;
  final String imgCover;

  OfferModel({
    required this.id,
    required this.title,
    required this.description,
    required this.quantity,
    required this.price,
    required this.imgCover,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      quantity: json['quantity'],
      price: json['price'].toDouble(),
      imgCover: json['imgCover'],
    );
  }
  String get getId => id;
  String get getTitle => title;
  String get getDescription => description;
  int get getQuantity => quantity;
  double get getPrice => price;
  String get getImgCover => imgCover;
}
