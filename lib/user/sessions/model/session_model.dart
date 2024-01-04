class SessionModel {
  final url;
  final title;
  final description;
  

  SessionModel({this.url, this.title, this.description, });

  factory SessionModel.fromJson(Map<Object?, dynamic> json) {
    return SessionModel(
      
      url: json['url'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
    );
  }
}
