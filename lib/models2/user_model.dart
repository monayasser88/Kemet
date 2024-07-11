class Profile {
  String? id;
  String? profilePic;
  String? firstName;
  String? lastName;
  String? city;
  String? email;

  Profile({
    this.id,
    this.profilePic,
    this.firstName,
    this.lastName,
    this.city,
    this.email,
  });

  factory Profile.fromJson(Map<String, dynamic> jsonData) {
    var user = jsonData['user'];
    return Profile(
      id: user != null ? user["_id"] : null,
      profilePic: user != null ? user["profileImg"] : null,
      email: user != null ? user["email"] : null,
      firstName: user != null ? user["firstName"] : null,
      lastName: user != null ? user["lastName"] : null,
      city: user != null ? user["city"] : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "profileImg": profilePic,
        "firstName": firstName,
        "lastName": lastName,
        "city": city,
        "email": email,
      };
}