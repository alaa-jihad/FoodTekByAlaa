import 'package:equatable/equatable.dart';
import 'package:foodtek_app/feature/home/domain/entity/select_category_item.dart';

class FavoritesState extends Equatable {
  final List<SelectCategoryItem> favoritedItems;

  const FavoritesState({required this.favoritedItems});

  FavoritesState copyWith({List<SelectCategoryItem>? favoritedItems}) {
    return FavoritesState(
      favoritedItems: favoritedItems ?? this.favoritedItems,
    );
  }

  @override
  List<Object> get props => [favoritedItems];
}