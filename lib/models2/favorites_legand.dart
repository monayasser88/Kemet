class Legands {
  String id;
  String name;
  String informationAbout;
  String imgCover;
  final List<String> images;

  Legands({
    required this.id,
    required this.name,
    required this.informationAbout,
    required this.imgCover,
    required this.images,
  });

  factory Legands.fromJson(Map<String, dynamic> json) {
    return Legands(
      id: json['_id'],
      name: json['name'],
      informationAbout: json['informationAbout'],
      imgCover: json['imgCover'],
      images: List<String>.from(json['images']),
    );
  }
}

class WishlistResponseLegand {
  String msg;
  List<Legands> wishListLegand;

  WishlistResponseLegand({
    required this.msg,
    required this.wishListLegand,
  });

  factory WishlistResponseLegand.fromJson(Map<String, dynamic> json) {
    return WishlistResponseLegand(
      msg: json['msg'],
      wishListLegand: List<Legands>.from(json['wishListLegend'].map((x) => Legands.fromJson(x))),
    );
  }
}