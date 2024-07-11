class TouristPlace {
  final String id;
  final String name;
  final String informationAbout;
  final String imgCover;
  final List<String> images;
  final Governate governrate;

  TouristPlace({
    required this.id,
    required this.name,
    required this.informationAbout,
    required this.imgCover,
    required this.images,
    required this.governrate,
  });

  factory TouristPlace.fromJson(Map<String, dynamic> json) {
    return TouristPlace(
      id: json['_id'],
      name: json['name'],
      informationAbout: json['informationAbout'],
      imgCover: json['imgCover'],
      images: List<String>.from(json['images']),
      governrate: Governate.fromJson(json['governrate']),
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