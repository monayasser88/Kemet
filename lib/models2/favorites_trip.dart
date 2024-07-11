class Trips {
  String id;
  String name;
  String informationAbout;
  String imgCover;
  final List<String> images;
  final double ratingAverage;
  final int quantity;
  final double price;
  final bool isOffered;
  final List<Review> reviews;

  Trips({
    required this.id,
    required this.name,
    required this.informationAbout,
    required this.imgCover,
    required this.images,
    required this.ratingAverage,
    required this.quantity,
    required this.price,
    required this.isOffered,
    required this.reviews,
  });

  factory Trips.fromJson(Map<String, dynamic> json) {
    return Trips(
      id: json['_id'],
      name: json['title'],
      informationAbout: json['description'],
      imgCover: json['imgCover'],
      images: json['images'] != null
          ? List<String>.from(json['images'])
          : [],
      ratingAverage: json['ratingAverage'] != null
          ? json['ratingAverage'].toDouble()
          : 0,
      quantity: json['quantity'],
      price: json['price'].toDouble(),
      isOffered: json['isOffered'],
      reviews: json['myReviews'] != null
          ? (json['myReviews'] as List<dynamic>)
              .map((reviewJson) => Review.fromJson(reviewJson))
              .toList()
          : [],
    );
  }
}

class WishlistResponseTrip {
  String msg;
  List<Trips> wishListTrip;

  WishlistResponseTrip({
    required this.msg,
    required this.wishListTrip,
  });

  factory WishlistResponseTrip.fromJson(Map<String, dynamic> json) {
    return WishlistResponseTrip(
      msg: json['msg'],
      wishListTrip: json['wishListTrip'] != null
          ? List<Trips>.from(json['wishListTrip'].map((x) => Trips.fromJson(x)))
          : [],
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
