class SelectCategoryItem {
  final String category;
  final String title;
  final String description;
  final String price;
  final String imagePath;

  SelectCategoryItem({
    required this.category,
    required this.title,
    required this.description,
    required this.price,
    required this.imagePath,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is SelectCategoryItem &&
              runtimeType == other.runtimeType &&
              category == other.category &&
              title == other.title &&
              description == other.description &&
              price == other.price &&
              imagePath == other.imagePath;

  @override
  int get hashCode =>
      category.hashCode ^
      title.hashCode ^
      description.hashCode ^
      price.hashCode ^
      imagePath.hashCode;
}