class Favorite {
  final int id;
  final String title;
  final String description;
  final String image;

  Favorite({required this.id, required this.title, required this.description,required this.image});

  factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
      id: json['id'], title: json['title'], description: json['description'], image: json['image']);
}
