class CartItem {
  final String name;
  final String restaurant;
  final double price;
  final String imagePath;
  int quantity;

  CartItem({
    required this.name,
    required this.restaurant,
    required this.price,
    required this.imagePath,
    this.quantity = 1,
  });
}