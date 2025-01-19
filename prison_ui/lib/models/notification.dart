class Notif {
  int id;
  int userId;
  String notificationType;
  String notificationMessage;

  Notif({
    required this.id,
    required this.userId,
    required this.notificationType,
    required this.notificationMessage
  });

  // Factory method to create a new instance from a map (useful for serialization)
  factory Notif.fromMap(Map<String, dynamic> map) {
    return Notif(
      id: map['id'],
      userId: map['userId'],
      notificationType: map['notificationType'],
      notificationMessage: map['notificationMessage']
    );
  }

  // Convert instance to a map (useful for saving to a database)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'notificationType':notificationType,
      'notificationMessage':notificationMessage
    };
  }
}
