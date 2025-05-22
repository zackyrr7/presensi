class NotificationModel {
  final int id;
  final String title;
  final String message;
  final bool isRead;
  final String createdAt;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.isRead,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      title: json['title'],
      message: json['message'],
      isRead: json['isread'] == 1, // Konversi 1 menjadi true
      createdAt: json['createdat'],
    );
  }

   static List<NotificationModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => NotificationModel.fromJson(item)).toList();
  }
}
