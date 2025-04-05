import 'package:flutter/material.dart';
import '../../domain/entity/cart_entity.dart';
import '../../domain/entity/history_entity.dart';

class CartState {
  final List<CartItem> cartItems;
  final List<HistoryItem> historyItems;
  final int visibleHistoryCount; // Number of history items to display

  CartState({
    required this.cartItems,
    required this.historyItems,
    this.visibleHistoryCount = 3, // Default to showing 3 items initially
  });

  CartState copyWith({
    List<CartItem>? cartItems,
    List<HistoryItem>? historyItems,
    int? visibleHistoryCount,
  }) {
    return CartState(
      cartItems: cartItems ?? this.cartItems,
      historyItems: historyItems ?? this.historyItems,
      visibleHistoryCount: visibleHistoryCount ?? this.visibleHistoryCount,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CartState) return false;

    // Compare cartItems
    if (cartItems.length != other.cartItems.length) return false;
    for (int i = 0; i < cartItems.length; i++) {
      final item1 = cartItems[i];
      final item2 = other.cartItems[i];
      if (item1.name != item2.name ||
          item1.restaurant != item2.restaurant ||
          item1.price != item2.price ||
          item1.imagePath != item2.imagePath ||
          item1.quantity != item2.quantity) {
        return false;
      }
    }

    // Compare historyItems
    if (historyItems.length != other.historyItems.length) return false;
    for (int i = 0; i < historyItems.length; i++) {
      final item1 = historyItems[i];
      final item2 = other.historyItems[i];
      if (item1.name != item2.name ||
          item1.restaurant != item2.restaurant ||
          item1.price != item2.price ||
          item1.imagePath != item2.imagePath ||
          item1.quantity != item2.quantity ||
          item1.timestamp != item2.timestamp) {
        return false;
      }
    }

    // Compare visibleHistoryCount
    if (visibleHistoryCount != other.visibleHistoryCount) return false;

    return true;
  }

  @override
  int get hashCode {
    int result = 17;
    for (var item in cartItems) {
      result = 37 * result + item.name.hashCode;
      result = 37 * result + item.restaurant.hashCode;
      result = 37 * result + item.price.hashCode;
      result = 37 * result + item.imagePath.hashCode;
      result = 37 * result + item.quantity.hashCode;
    }
    for (var item in historyItems) {
      result = 37 * result + item.name.hashCode;
      result = 37 * result + item.restaurant.hashCode;
      result = 37 * result + item.price.hashCode;
      result = 37 * result + item.imagePath.hashCode;
      result = 37 * result + item.quantity.hashCode;
      result = 37 * result + item.timestamp.hashCode;
    }
    result = 37 * result + visibleHistoryCount.hashCode;
    return result;
  }
}