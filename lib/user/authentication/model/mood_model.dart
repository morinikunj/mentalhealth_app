class MoodModel {
  final uid;
  final happy;
  final sad;
  final angry;
  final normal;
  MoodModel({this.angry, this.happy, this.normal, this.sad, this.uid});

  factory MoodModel.fromJson(Map<Object?, dynamic> json) {
    return MoodModel(
       uid: json['uid'] as String? ?? '',
       happy: json['happy'] as String? ?? '',
       sad: json['sad'] as String? ?? '',
       angry: json['angry'] as String? ?? '',
       normal: json['normal'] as String? ?? '',
    );
  }
}
