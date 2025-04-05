// package:foodtek_app/feature/home/domain/entity/top_rated_item.dart
class TopRatedItem {
  final double rating;
  final String imagePath;
  final String title;
  final String description;
  final String price;

  TopRatedItem({
    required this.rating,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.price,
  });
}