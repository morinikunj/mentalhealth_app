class UserModel {
   String? imageUrl;
  String? userid;
  final String name;
  final String email;
  final String phoneno;
  final String dob;
  final String profession;
  final String location;

  UserModel(
      {this.userid,
      this.imageUrl,
      required this.name,
      required this.email,
      required this.phoneno,
      required this.dob,
      required this.profession,
      required this.location});

  factory UserModel.fromJson(Map<Object?, dynamic> json) {
    return UserModel(
      imageUrl: json['imageUrl'] as String? ?? '',
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phoneno: json['phoneNo'] as String? ?? '',
      dob: json['dob'] as String? ?? '',
      profession: json['profession'] as String? ?? '',
      location: json['location'] as String? ?? '',
    );
  }
}
