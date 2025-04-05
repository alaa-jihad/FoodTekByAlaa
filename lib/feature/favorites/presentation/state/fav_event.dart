import 'package:equatable/equatable.dart';
import 'package:foodtek_app/feature/home/domain/entity/select_category_item.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

class LoadFavorites extends FavoritesEvent {}

class ToggleFavorite extends FavoritesEvent {
  final SelectCategoryItem item;

  const ToggleFavorite(this.item);

  @override
  List<Object> get props => [item];
}