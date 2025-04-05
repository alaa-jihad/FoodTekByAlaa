import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foodtek_app/feature/home/domain/entity/select_category_item.dart';

import '../state/fav_event.dart';
import '../state/fav_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  FavoritesBloc() : super(const FavoritesState(favoritedItems: [])) {
    on<LoadFavorites>(_onLoadFavorites);
    on<ToggleFavorite>(_onToggleFavorite);
  }

  Future<void> _onLoadFavorites(LoadFavorites event, Emitter<FavoritesState> emit) async {
    try {
      final String? favoritesJson = await _storage.read(key: 'favoritedItems');
      if (favoritesJson != null) {
        final List<dynamic> favoritesList = jsonDecode(favoritesJson);
        final List<SelectCategoryItem> favoritedItems = favoritesList
            .map((json) => SelectCategoryItem(
          category: json['category'],
          title: json['title'],
          description: json['description'],
          price: json['price'],
          imagePath: json['imagePath'],
        ))
            .toList();
        emit(FavoritesState(favoritedItems: favoritedItems));
      }
    } catch (e) {
      print('Error loading favorites: $e');
      emit(const FavoritesState(favoritedItems: []));
    }
  }

  Future<void> _onToggleFavorite(ToggleFavorite event, Emitter<FavoritesState> emit) async {
    final List<SelectCategoryItem> updatedFavorites = List.from(state.favoritedItems);
    if (updatedFavorites.contains(event.item)) {
      updatedFavorites.remove(event.item);
    } else {
      updatedFavorites.add(event.item);
    }

    emit(FavoritesState(favoritedItems: updatedFavorites));

    // Save to secure storage
    try {
      final favoritesJson = updatedFavorites
          .map((item) => {
        'category': item.category,
        'title': item.title,
        'description': item.description,
        'price': item.price,
        'imagePath': item.imagePath,
      })
          .toList();
      await _storage.write(key: 'favoritedItems', value: jsonEncode(favoritesJson));
    } catch (e) {
      print('Error saving favorites: $e');
    }
  }
}