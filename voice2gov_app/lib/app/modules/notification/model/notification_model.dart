class NotificationModel {
  final String id;
  final String title;
  final String message;
  final DateTime time;
  final String iconUrl;
  final bool isRead;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    required this.iconUrl,
    required this.isRead,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      time: DateTime.tryParse(json['time'] ?? '') ?? DateTime.now(),
      iconUrl: json['iconUrl'] ?? 'https://img.icons8.com/fluency/48/bell.png',
      isRead: json['isRead'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'message': message,
        'time': time.toIso8601String(),
        'iconUrl': iconUrl,
        'isRead': isRead,
      };
}