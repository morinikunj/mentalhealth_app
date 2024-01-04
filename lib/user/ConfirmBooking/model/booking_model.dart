class Appointment {
  String? userimageurl;
  String userId;
  String username;
  String expertname;
  String fees;
  String time;
  String date;
  String status;
  String image;
  String? key;
  String? payment_id;
  String? paid;

  Appointment(
      {required this.username,
      this.userimageurl,
      this.key,
      this.paid,
      this.payment_id,
      required this.image,
      required this.expertname,
      required this.fees,
      required this.date,
      required this.time,
      required this.userId,
      required this.status});

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'userimageurl': userimageurl,
      'image': image,
      'username': username,
      'expertname': expertname,
      'fees': fees,
      'timeslot': time,
      'date': date,
      'status': status,
      'paid': paid,
      'payment_id': payment_id,
      'userId': userId,
    };
  }

  factory Appointment.fromJson(Map<Object?, dynamic> json) {
    return Appointment(
        paid: json['paid'] ?? '',
        payment_id: json['payment_id'] ?? '',
        key: json['key'] ?? '',
        userimageurl: json['userimageurl'] ?? '',
        image: json['image'] ?? '',
        username: json['username'] ?? '',
        expertname: json['expertname'] ?? '',
        fees: json['fees'] ?? '',
        date: json['date'] ?? '',
        time: json['timeslot'] ?? '',
        userId: json['userId'] ?? '',
        status: json['status'] ?? '');
  }
}
