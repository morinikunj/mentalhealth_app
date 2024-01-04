class ExpertModel {
  final String imageUrl;
  final String userid;
  final String name;
  final String email;
  final String phoneno;
  final String experience;
  final String profession;
  final String city;
  String? about;
  String? fees;
  String? street;

  ExpertModel(
      {required this.imageUrl,
      required this.userid,
      required this.name,
      this.about,
      this.street,
      this.fees,
      required this.email,
      required this.phoneno,
      required this.experience,
      required this.profession,
      required this.city});

  factory ExpertModel.fromJson(Map<Object?, dynamic> json) {
    return ExpertModel(
      street: json['street'] as String? ?? '',
      city: json['city'] as String? ?? '',
      fees: json['fees'] as String? ?? '',
      about: json['about'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
      userid: json['userid'] as String? ?? '',
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phoneno: json['phoneNo'] as String? ?? '',
      experience: json['experience'] as String? ?? '',
      profession: json['profession'] as String? ?? '',
      
    );
  }
}
