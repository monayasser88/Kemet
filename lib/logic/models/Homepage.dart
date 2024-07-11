class UserModel {
  final String firstName;
   final String profileImg;
  // final String name;

  UserModel({required this.firstName,required this.profileImg});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['user']['firstName'],
      profileImg: json['user']['profileImg'],
      // image: json['document']['image'],
      // name: json['document']['name']
    );
  }
}
