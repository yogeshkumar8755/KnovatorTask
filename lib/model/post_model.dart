

class PostModel {
  final int id;
  final String title;
  final String body;
  bool isRead;
  int remainingTime;

  PostModel({
    required this.id,
    required this.title,
    required this.body,
    this.isRead = false,
    required this.remainingTime,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'body': body,
        'isRead': isRead,
        'remainingTime': remainingTime,
      };

  static PostModel fromJson(Map<String, dynamic> json) => PostModel(
        id: json['id'],
        title: json['title'],
        body: json['body'],
        isRead: json['isRead'] ?? false,
        remainingTime: json['remainingTime'] ?? 25,
      );
}

