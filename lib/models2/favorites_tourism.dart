class TourismPlace {
  String id;
  String name;
  String informationAbout;
  String imgCover;
  final List<String> images;
  Governate governrate;

  TourismPlace({
    required this.id,
    required this.name,
    required this.informationAbout,
    required this.imgCover,
    required this.images,
    required this.governrate,
  });

  factory TourismPlace.fromJson(Map<String, dynamic> json) {
    return TourismPlace(
      id: json['_id'],
      name: json['name'],
      informationAbout: json['informationAbout'],
      imgCover: json['imgCover'],
      images: List<String>.from(json['images']),
      governrate:Governate.fromJson(json['governrate']),
    );
  }
}

class WishlistResponse {
  String msg;
  List<TourismPlace> wishListTourismPlace;

  WishlistResponse({
    required this.msg,
    required this.wishListTourismPlace,
  });

  factory WishlistResponse.fromJson(Map<String, dynamic> json) {
    return WishlistResponse(
      msg: json['msg'],
      wishListTourismPlace: List<TourismPlace>.from(json['wishListTourismPlace'].map((x) => TourismPlace.fromJson(x))),
    );
  }
}
class Governate {
  final String id;
  final String name;
  final String image;

  Governate({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Governate.fromJson(Map<String, dynamic> json) {
    return Governate(
      id: json['_id'],
      name: json['name'],
      image: json['image'],
    );
  }
}
