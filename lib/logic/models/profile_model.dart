class Profile {
  String? id;
  String? photo;
  String? firstName;
  String? lastName;
  String? city;
  String? email;

  Profile({
    this.id,
    this.photo,
    this.firstName,
    this.lastName,
    this.city,
    this.email
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    id: json["_id"],
    photo: json["photo"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    city: json["city"],
    email: json["email"]
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "photo": photo,
    "firstName": firstName,
    "lastName": lastName,
    "city": city,
    "email": email
  };

}
