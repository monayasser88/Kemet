class Trip {
  final String id;
  final String title;
  final String description;
  final int quantity;
  final double price;
  final String imageUrl;
  final bool isOffered;
  final List<String> images;
  final List<Review> reviews;
  final double ratingAverage;
 
  Trip({
required this.id,
    required this.title,
    required this.description,
    required this.quantity,
    required this.price,
    required this.imageUrl,
    required this.isOffered,
    required this.images,
required this.reviews,
    required this.ratingAverage,
  });
 
  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      quantity: json['quantity'],
      price: json['price'].toDouble(),
      imageUrl: json['imgCover'],
      isOffered: json['isOffered'],
      images: List<String>.from(json['images']),
      ratingAverage:
          json['ratingAverage'] != null ? json['ratingAverage'].toDouble() : 0,
      reviews: (json['myReviews'] as List<dynamic>)
          .map((reviewJson) => Review.fromJson(reviewJson))
          .toList(),
    );
  }
}
 
class Review {
  final String id;
  final String text;
  final int rate;
 
  Review({
required this.id,
    required this.text,
    required this.rate,
  });
 
  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['_id'],
      text: json['text'],
      rate: json['rate'],
    );
  }
}