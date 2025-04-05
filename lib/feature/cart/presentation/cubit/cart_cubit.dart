import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodtek_app/core/constants/jpg.dart';
import '../../domain/entity/cart_entity.dart';
import '../../domain/entity/history_entity.dart';
import '../state/cart_event.dart';
import '../state/cart_state.dart';


class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState(cartItems: [], historyItems: _initialHistoryItems())) {
    on<AddToCartEvent>(_onAddToCart);
    on<RemoveFromCartEvent>(_onRemoveFromCart);
    on<UpdateQuantityEvent>(_onUpdateQuantity);
    on<ClearCartEvent>(_onClearCart);
    on<LoadMoreHistoryEvent>(_onLoadMoreHistory);
    on<ReorderEvent>(_onReorder);
    on<AddToHistoryEvent>(_onAddToHistory);
    on<RemoveFromHistoryEvent>(_onRemoveFromHistory); // New event handler
  }

  static List<HistoryItem> _initialHistoryItems() {
    return [
      HistoryItem(
        name: 'Chicken Burger',
        restaurant: 'Burger Factory LTD',
        price: 20,
        imagePath: JPGs.burger,
        quantity: 1,
        timestamp: '20.23.2024',
      ),
      HistoryItem(
        name: 'Onion Pizza',
        restaurant: 'Pizza Palace',
        price: 15,
        imagePath: JPGs.pizza,
        quantity: 1,
        timestamp: '20.23.2024',
      ),
      HistoryItem(
        name: 'Spicy Shawarma',
        restaurant: 'Shawarma Hub',
        price: 15,
        imagePath: JPGs.sandwihes1,
        quantity: 1,
        timestamp: '20.23.2024',
      ),
      HistoryItem(
        name: 'Cheeseburger',
        restaurant: 'Burger Factory LTD',
        price: 18,
        imagePath: JPGs.chicken,
        quantity: 1,
        timestamp: '19.23.2024',
      ),
    ];
  }

  void _onAddToCart(AddToCartEvent event, Emitter<CartState> emit) {
    final currentItems = List<CartItem>.from(state.cartItems);
    final existingItemIndex = currentItems.indexWhere(
          (cartItem) => cartItem.name == event.item.name && cartItem.restaurant == event.item.restaurant,
    );

    if (existingItemIndex != -1) {
      currentItems[existingItemIndex] = CartItem(
        name: currentItems[existingItemIndex].name,
        restaurant: currentItems[existingItemIndex].restaurant,
        price: currentItems[existingItemIndex].price,
        imagePath: currentItems[existingItemIndex].imagePath,
        quantity: currentItems[existingItemIndex].quantity + event.item.quantity,
      );
    } else {
      currentItems.add(event.item);
    }

    emit(state.copyWith(cartItems: currentItems));
  }

  void _onRemoveFromCart(RemoveFromCartEvent event, Emitter<CartState> emit) {
    final currentItems = List<CartItem>.from(state.cartItems);
    if (event.index >= 0 && event.index < currentItems.length) {
      currentItems.removeAt(event.index);
      emit(state.copyWith(cartItems: currentItems));
    }
  }

  void _onUpdateQuantity(UpdateQuantityEvent event, Emitter<CartState> emit) {
    final currentItems = List<CartItem>.from(state.cartItems);
    if (event.index >= 0 && event.index < currentItems.length) {
      final item = currentItems[event.index];
      int newQuantity = item.quantity;

      if (event.increase) {
        newQuantity++;
      } else {
        if (item.quantity > 1) {
          newQuantity--;
        }
      }

      currentItems[event.index] = CartItem(
        name: item.name,
        restaurant: item.restaurant,
        price: item.price,
        imagePath: item.imagePath,
        quantity: newQuantity,
      );

      emit(state.copyWith(cartItems: currentItems));
    }
  }

  void _onClearCart(ClearCartEvent event, Emitter<CartState> emit) {
    emit(state.copyWith(cartItems: []));
  }

  void _onLoadMoreHistory(LoadMoreHistoryEvent event, Emitter<CartState> emit) {
    final newVisibleCount = state.visibleHistoryCount + 3;
    emit(state.copyWith(visibleHistoryCount: newVisibleCount));
  }

  void _onReorder(ReorderEvent event, Emitter<CartState> emit) {
    final currentItems = List<CartItem>.from(state.cartItems);
    final existingItemIndex = currentItems.indexWhere(
          (cartItem) => cartItem.name == event.historyItem.name && cartItem.restaurant == event.historyItem.restaurant,
    );

    if (existingItemIndex != -1) {
      currentItems[existingItemIndex] = CartItem(
        name: currentItems[existingItemIndex].name,
        restaurant: currentItems[existingItemIndex].restaurant,
        price: currentItems[existingItemIndex].price,
        imagePath: currentItems[existingItemIndex].imagePath,
        quantity: currentItems[existingItemIndex].quantity + 1,
      );
    } else {
      final cartItem = CartItem(
        name: event.historyItem.name,
        restaurant: event.historyItem.restaurant,
        price: event.historyItem.price,
        imagePath: event.historyItem.imagePath,
        quantity: 1,
      );
      currentItems.add(cartItem);
    }

    emit(state.copyWith(cartItems: currentItems));
  }

  void _onAddToHistory(AddToHistoryEvent event, Emitter<CartState> emit) {
    final currentHistory = List<HistoryItem>.from(state.historyItems);
    final historyItem = HistoryItem(
      name: event.cartItem.name,
      restaurant: event.cartItem.restaurant,
      price: event.cartItem.price,
      imagePath: event.cartItem.imagePath,
      quantity: event.cartItem.quantity,
      timestamp: '04.05.2025',
    );
    currentHistory.insert(0, historyItem);
    emit(state.copyWith(historyItems: currentHistory));
  }

  void _onRemoveFromHistory(RemoveFromHistoryEvent event, Emitter<CartState> emit) {
    final currentHistory = List<HistoryItem>.from(state.historyItems);
    if (event.index >= 0 && event.index < currentHistory.length) {
      currentHistory.removeAt(event.index);
      emit(state.copyWith(historyItems: currentHistory));
    }
  }
}