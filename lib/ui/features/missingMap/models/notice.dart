class Notice {
  int id;
  String title;
  String content;
  String date;

  Notice(
      {required this.id,
      required this.title,
      required this.content,
      required this.date});

  factory Notice.fromJson(Map<String, dynamic> json) {
    return Notice(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      date: json['date'] ?? '',
    );
  }
}
