import 'package:flutter/material.dart';
import '../../domain/entity/cart_entity.dart';
import '../../domain/entity/history_entity.dart';

abstract class CartEvent {}

class AddToCartEvent extends CartEvent {
  final CartItem item;

  AddToCartEvent(this.item);
}

class RemoveFromCartEvent extends CartEvent {
  final int index;

  RemoveFromCartEvent(this.index);
}

class UpdateQuantityEvent extends CartEvent {
  final int index;
  final bool increase;

  UpdateQuantityEvent(this.index, this.increase);
}

class ClearCartEvent extends CartEvent {}

class LoadMoreHistoryEvent extends CartEvent {}

class ReorderEvent extends CartEvent {
  final HistoryItem historyItem;

  ReorderEvent(this.historyItem);
}

class AddToHistoryEvent extends CartEvent {
  final CartItem cartItem;

  AddToHistoryEvent(this.cartItem);
}

class RemoveFromHistoryEvent extends CartEvent {
  final int index;

  RemoveFromHistoryEvent(this.index);
}