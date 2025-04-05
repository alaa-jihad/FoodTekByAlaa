class HistoryItem {
  final String name;
  final String restaurant;
  final double price;
  final String imagePath;
  final int quantity;
  final String timestamp; // e.g., "20.23.2024"

  HistoryItem({
    required this.name,
    required this.restaurant,
    required this.price,
    required this.imagePath,
    required this.quantity,
    required this.timestamp,
  });
}