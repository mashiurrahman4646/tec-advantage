class NotificationModel {
  final String id;
  final String title;
  final String description;
  final String fcmToken;
  final bool read;
  final DateTime sentAt;

  NotificationModel({
    required this.id,
    required this.title,
    required this.description,
    required this.fcmToken,
    required this.read,
    required this.sentAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      fcmToken: json['fcmToken'] ?? '',
      read: json['read'] ?? false,
      sentAt:
          DateTime.parse(json['sentAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'fcmToken': fcmToken,
      'read': read,
      'sentAt': sentAt.toIso8601String(),
    };
  }

  NotificationModel copyWith({
    String? id,
    String? title,
    String? description,
    String? fcmToken,
    bool? read,
    DateTime? sentAt,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      fcmToken: fcmToken ?? this.fcmToken,
      read: read ?? this.read,
      sentAt: sentAt ?? this.sentAt,
    );
  }
}
