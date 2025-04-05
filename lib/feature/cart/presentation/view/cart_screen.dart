import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodtek_app/core/constants/png.dart';
import 'package:foodtek_app/core/constants/svg.dart';
import 'package:foodtek_app/core/constants/color.dart';
import 'package:foodtek_app/core/utils/responsive.dart';
import 'package:foodtek_app/core/presentation/widget/custom_app_bar.dart';
import 'package:foodtek_app/feature/cart/domain/entity/cart_entity.dart';
import 'package:foodtek_app/feature/cart/presentation/cubit/cart_cubit.dart';
import 'package:foodtek_app/feature/cart/presentation/state/cart_event.dart';
import 'package:foodtek_app/feature/cart/presentation/state/cart_state.dart';
import 'package:foodtek_app/feature/track/presentation/view/track_screen.dart';
import 'package:foodtek_app/feature/checkout/presentation/view/checkout_screen.dart';

import '../../domain/entity/history_entity.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String _selectedTab = 'Cart';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        final subTotal = state.cartItems.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
        const deliveryCharge = 10.0;
        const discount = 10.0;
        final total = subTotal + deliveryCharge - discount;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBar(
            preColor: COLORs.appbar,
            preIcon: SVGs.appbar_location,
            locationTitle: "Current location",
            locationName: "Jl. Soekarno Hatta 15A..",
            suffixColor: COLORs.suffixIcon,
            suffixIcon: SVGs.appbar_notification,
            appBarHeight: responsiveHeight(context, 41.0),
            onNotificationTap: () {
              // Placeholder for notification action if needed
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notifications not implemented yet')),
              );
            },
          ),
          body: Stack(
            children: [
              Positioned(
                top: 16,
                left: 20,
                right: 20,
                child: Row(
                  children: [
                    _buildTab('Cart', _selectedTab == 'Cart'),
                    _buildTab('History', _selectedTab == 'History'),
                  ],
                ),
              ),
              if (_selectedTab == 'Cart') ...[
                if (state.cartItems.isEmpty) ...[
                  Positioned(
                    top: 70,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          PNGs.empty,
                          width: responsiveWidth(context, 200.0),
                          height: responsiveHeight(context, 200.0),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Cart Empty',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Color(0xFF391713),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "You don't have any foods in cart at this time",
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Color(0xFF606060),
                          ),
                        ),
                      ],
                    ),
                  ),
                ] else ...[
                  Positioned(
                    top: 70,
                    left: 20,
                    right: 20,
                    bottom: 206,
                    child: ListView.builder(
                      itemCount: state.cartItems.length,
                      itemBuilder: (context, index) {
                        final item = state.cartItems[index];
                        return _buildDismissibleCartItem(context, item, index);
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 26,
                    left: 16,
                    right: 16,
                    child: Container(
                      height: 229,
                      width: 378,
                      decoration: BoxDecoration(
                        color: const Color(0xFF3E6898),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(7),
                          topRight: Radius.circular(7),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.07),
                            offset: const Offset(12, 26),
                            blurRadius: 50,
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Opacity(
                              opacity: 0.2,
                              child: Image.asset(
                                PNGs.card,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                _buildPriceRow('Sub-Total', '\$${subTotal.toStringAsFixed(0)}'),
                                _buildPriceRow('Delivery Charge', '\$${deliveryCharge.toStringAsFixed(0)}'),
                                _buildPriceRow('Discount', '-\$${discount.toStringAsFixed(0)}'),
                                _buildPriceRow('TOTAL:', '\$${total.toStringAsFixed(0)}', isTotal: true),
                                const SizedBox(height: 14),
                                GestureDetector(
                                  onTap: () {
                                    final currentContext = context;
                                    Navigator.push(
                                      currentContext,
                                      MaterialPageRoute(
                                        builder: (context) => TrackScreen(
                                          cartItems: state.cartItems,
                                          onLocationSelected: (latLng, url) {
                                            if (latLng != null) {
                                              Navigator.pushReplacement(
                                                currentContext,
                                                MaterialPageRoute(
                                                  builder: (context) => CheckoutScreen(
                                                    selectedLocation: latLng,
                                                    locationUrl: url,
                                                    cartItems: state.cartItems,
                                                    onChangeLocation: () {
                                                      Navigator.push(
                                                        currentContext,
                                                        MaterialPageRoute(
                                                          builder: (context) => TrackScreen(
                                                            cartItems: state.cartItems,
                                                            initialLocation: latLng,
                                                            onLocationSelected: (newLatLng, newUrl) {
                                                              if (newLatLng != null) {
                                                                Navigator.pushReplacement(
                                                                  currentContext,
                                                                  MaterialPageRoute(
                                                                    builder: (context) => CheckoutScreen(
                                                                      selectedLocation: newLatLng,
                                                                      locationUrl: newUrl,
                                                                      cartItems: state.cartItems,
                                                                      onChangeLocation: () {},
                                                                      onOrderPlaced: () {
                                                                        context.read<CartBloc>().add(ClearCartEvent());
                                                                        Navigator.popUntil(
                                                                          currentContext,
                                                                              (route) => route.isFirst,
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                );
                                                              }
                                                            },
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    onOrderPlaced: () {
                                                      context.read<CartBloc>().add(ClearCartEvent());
                                                      Navigator.popUntil(
                                                        currentContext,
                                                            (route) => route.isFirst,
                                                      );
                                                    },
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                          initialLocation: null,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: 366,
                                    height: 57,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    child: const Center(
                                      child: Text(
                                        'Place My Order',
                                        style: TextStyle(
                                          color: Color(0xFF3E6898),
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ] else ...[
                if (state.historyItems.isEmpty) ...[
                  Positioned(
                    top: 70,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          PNGs.empty,
                          width: responsiveWidth(context, 200.0),
                          height: responsiveHeight(context, 200.0),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'History Empty',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Color(0xFF391713),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "You don't have ordered any foods",
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Color(0xFF606060),
                          ),
                        ),
                      ],
                    ),
                  ),
                ] else ...[
                  Positioned(
                    top: 70,
                    left: 20,
                    right: 20,
                    bottom: 0,
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.visibleHistoryCount > state.historyItems.length
                                ? state.historyItems.length
                                : state.visibleHistoryCount,
                            itemBuilder: (context, index) {
                              final item = state.historyItems[index];
                              return _buildDismissibleHistoryItem(context, item, index);
                            },
                          ),
                        ),
                        if (state.visibleHistoryCount < state.historyItems.length) ...[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: GestureDetector(
                              onTap: () {
                                context.read<CartBloc>().add(LoadMoreHistoryEvent());
                              },
                              child: const Text(
                                'Load More...',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Color(0xFF3E6898),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildTab(String text, bool isActive) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTab = text;
          });
        },
        child: Container(
          height: 26,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isActive ? const Color(0xFF3E6898) : const Color(0xFFF5F5F5),
                width: 1,
              ),
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: isActive ? const Color(0xFF3E6898) : const Color(0xFF98A0B4),
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDismissibleCartItem(BuildContext context, CartItem item, int index) {
    return Dismissible(
      key: Key(item.name),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        context.read<CartBloc>().add(RemoveFromCartEvent(index));
      },
      background: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
        ),
        child: Align(
          alignment: Alignment.centerRight,
          child: Container(
            width: 387,
            height: 85,
            decoration: const BoxDecoration(
              color: Color(0xFFFDAC1D),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(7),
                bottomRight: Radius.circular(7),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: SvgPicture.asset(
                  SVGs.trash,
                  width: 25,
                  height: 25,
                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
              ),
            ),
          ),
        ),
      ),
      child: _buildCartItem(context, item, index),
    );
  }

  Widget _buildDismissibleHistoryItem(BuildContext context, HistoryItem item, int index) {
    return Dismissible(
      key: Key(item.name),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        context.read<CartBloc>().add(RemoveFromHistoryEvent(index));
      },
      background: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
        ),
        child: Align(
          alignment: Alignment.centerRight,
          child: Container(
            width: 387,
            height: 85,
            decoration: const BoxDecoration(
              color: Color(0xFFFDAC1D),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(7),
                bottomRight: Radius.circular(7),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: SvgPicture.asset(
                  SVGs.trash,
                  width: 25,
                  height: 25,
                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
              ),
            ),
          ),
        ),
      ),
      child: _buildHistoryItem(context, item, index),
    );
  }

  Widget _buildCartItem(BuildContext context, CartItem item, int index) {
    return Container(
      height: 103,
      margin: const EdgeInsets.only(bottom: 16),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(7),
              border: Border.all(color: const Color(0xFFDBF4D1)),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: Image.asset(
                      item.imagePath,
                      width: 62,
                      height: 62,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: SizedBox(
                      height: 70,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name,
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              height: 1.31,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            item.restaurant,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              letterSpacing: 0.5,
                              color: const Color(0xFF3B3B3B).withOpacity(0.3),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '\$${item.price.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              fontSize: 19,
                              height: 1.31,
                              color: Color(0xFF3E6898),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: SizedBox(
                    width: 92,
                    height: 26,
                    child: Row(
                      children: [
                        _buildQuantityButton('-', Colors.transparent, () {
                          context.read<CartBloc>().add(UpdateQuantityEvent(index, false));
                        }),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: Text(
                            item.quantity.toString(),
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Color(0xFF181818),
                              letterSpacing: 0.57,
                            ),
                          ),
                        ),
                        _buildQuantityButton('+', const Color(0xFF3E6898), () {
                          context.read<CartBloc>().add(UpdateQuantityEvent(index, true));
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(BuildContext context, HistoryItem item, int index) {
    return Container(
      height: 103,
      margin: const EdgeInsets.only(bottom: 16),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(7),
              border: Border.all(color: const Color(0xFFDBF4D1)),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: Image.asset(
                      item.imagePath,
                      width: 62,
                      height: 62,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: SizedBox(
                      height: 70,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name,
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              height: 1.31,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            item.restaurant,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              letterSpacing: 0.5,
                              color: const Color(0xFF3B3B3B).withOpacity(0.3),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '\$${item.price.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              fontSize: 19,
                              height: 1.31,
                              color: Color(0xFF3E6898),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: SizedBox(
                    width: 92,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          item.timestamp,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                            color: Color(0xFF3E6898),
                          ),
                        ),
                        const SizedBox(height: 4),
                        GestureDetector(
                          onTap: () {
                            context.read<CartBloc>().add(ReorderEvent(item));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Item reordered!')),
                            );
                          },
                          child: const Text(
                            'Reorder',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Color(0xFF3E6898),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityButton(String text, Color bgColor, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 26,
        height: 26,
        decoration: BoxDecoration(
          color: bgColor.withOpacity(bgColor == Colors.transparent ? 0.1 : 1.0),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: bgColor == Colors.transparent ? const Color(0xFF3E6898) : Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.w400,
              fontSize: isTotal ? 18 : 14,
              letterSpacing: isTotal ? 0.64 : 0.5,
              color: const Color(0xFFFEFEFF),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.w400,
              fontSize: isTotal ? 18 : 14,
              letterSpacing: isTotal ? 0.64 : 0.5,
              color: const Color(0xFFFEFEFF),
            ),
          ),
        ],
      ),
    );
  }
}