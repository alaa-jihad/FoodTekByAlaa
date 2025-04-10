class NotificationItem {
  final String title;
  final String message;
  final String timestamp;
  final bool isRead;

  NotificationItem({
    required this.title,
    required this.message,
    required this.timestamp,
    this.isRead = false,
  });
}