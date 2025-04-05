import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodtek_app/core/constants/color.dart';
import 'package:foodtek_app/core/presentation/button/custom_button.dart';
import 'package:foodtek_app/core/utils/responsive.dart';
import '../../../../core/constants/svg.dart';
import '../../../../core/presentation/widget/custom_app_bar.dart';
import '../../../../core/presentation/widget/custom_search_bar.dart';
import '../../../cart/domain/entity/cart_entity.dart';
import '../../../cart/presentation/cubit/cart_cubit.dart';
import '../../../cart/presentation/state/cart_event.dart';
import '../../../main_screen/main_screen.dart';
import '../../../notification/domain/entity/notification_item.dart';
import '../../../notification/presentation/view/notification_screen.dart';


class DetailsScreen extends StatefulWidget {
  final String imagePath;
  final String price;
  final String title;
  final String description;
  final double rating;

  const DetailsScreen({
    super.key,
    required this.imagePath,
    required this.price,
    required this.title,
    required this.description,
    this.rating = 0.0,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  double _spiciness = 0.5;
  int _quantity = 3;

  void _onItemTapped(int index) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainScreen(selectedIndex: index),
      ),
    );
  }

  final List<NotificationItem> notifications = [
    NotificationItem(
      title: 'Delayed Order:',
      message: "We're sorry! Your order is running late. New ETA: 10:30 PM. Thanks for your patience!",
      timestamp: 'Last Wednesday at 9:42 AM',
      isRead: false,
    ),
    NotificationItem(
      title: 'Promotional Offer:',
      message: 'Craving something delicious? 🍔 Get 20% off on your next order. Use code: YUMMY20.',
      timestamp: 'Last Wednesday at 9:42 AM',
      isRead: true,
    ),
    NotificationItem(
      title: 'Out for Delivery:',
      message: 'Your order is on the way! 🚗 Estimated arrival: 15 mins. Stay hungry!',
      timestamp: 'Last Wednesday at 9:42 AM',
      isRead: true,
    ),
    NotificationItem(
      title: 'Order Confirmation:',
      message: "Your order has been placed! 🍔 We're preparing it now. Track your order live!",
      timestamp: 'Last Wednesday at 9:42 AM',
      isRead: true,
    ),
    NotificationItem(
      title: 'Delivered:',
      message: 'Enjoy your meal! 🍕 Your order has been delivered. Rate your experience!',
      timestamp: 'Last Wednesday at 9:42 AM',
      isRead: true,
    ),
  ];

  void _showNotificationBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => NotificationBottomSheet(notifications: notifications),
    );
  }

  void _addToCart() {
    final cartItem = CartItem(
      name: widget.title,
      restaurant: 'Burger Factory LTD',
      price: double.parse(widget.price.replaceAll('\$', '')),
      imagePath: widget.imagePath,
      quantity: _quantity,
    );
    context.read<CartBloc>().add(AddToCartEvent(cartItem));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Item added to cart!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLORs.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: CustomAppBar(
          preColor: COLORs.appbar,
          preIcon: SVGs.appbar_location,
          locationTitle: "Current location",
          locationName: "Jl. Soekarno Hatta 15A..",
          suffixColor: COLORs.suffixIcon,
          suffixIcon: SVGs.appbar_notification,
          appBarHeight: responsiveHeight(context, 41.0),
          onNotificationTap: _showNotificationBottomSheet,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14.0, 16.0, 14.0, 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: responsiveHeight(context, 22.0)),
              Center(child: CustomSearchBar()),
              SizedBox(height: responsiveHeight(context, 30.0)),
              Center(
                child: Container(
                  width: responsiveWidth(context, 370.0),
                  height: responsiveHeight(context, 203.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage(widget.imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: responsiveHeight(context, 20.0)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: responsiveWidth(context, 16.0)),
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: responsiveWidth(context, 20.0),
                    color: const Color(0xFF391713),
                  ),
                ),
              ),
              SizedBox(height: responsiveHeight(context, 8.0)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: responsiveWidth(context, 16.0)),
                child: Row(
                  children: [
                    Row(
                      children: List.generate(5, (index) {
                        double rating = widget.rating > 0 ? widget.rating : 4.5;
                        if (index < rating.floor()) {
                          return const Icon(
                            Icons.star,
                            color: Color(0xFFFF9F06),
                            size: 16,
                          );
                        } else if (index < rating) {
                          return const Icon(
                            Icons.star_half,
                            color: Color(0xFFFF9F06),
                            size: 16,
                          );
                        } else {
                          return const Icon(
                            Icons.star_border,
                            color: Color(0xFFFF9F06),
                            size: 16,
                          );
                        }
                      }),
                    ),
                    SizedBox(width: responsiveWidth(context, 4.0)),
                    Text(
                      widget.rating > 0 ? widget.rating.toString() : '4.5',
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        fontWeight: FontWeight.w400,
                        fontSize: responsiveWidth(context, 12.0),
                        color: const Color(0xFF0D0D0D),
                      ),
                    ),
                    SizedBox(width: responsiveWidth(context, 8.0)),
                    Text(
                      '(89 reviews)',
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        fontWeight: FontWeight.w400,
                        fontSize: responsiveWidth(context, 12.0),
                        color: const Color(0xFF878787),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Text(
                      '\$${double.parse(widget.price.replaceAll('\$', '')).toStringAsFixed(2)}',
                      style: TextStyle(
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w700,
                        fontSize: responsiveWidth(context, 18.0),
                        color: const Color(0xFF3E6898),
                      ),
                    ),
                    SizedBox(width: responsiveWidth(context, 8.0)),
                    Text(
                      '\$${double.parse(widget.price.replaceAll('\$', '')) + 1.51}',
                      style: TextStyle(
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w400,
                        fontSize: responsiveWidth(context, 14.0),
                        color: const Color(0xFF878787),
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: responsiveHeight(context, 16.0)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: responsiveWidth(context, 16.0)),
                child: Text(
                  widget.description,
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    fontWeight: FontWeight.w400,
                    fontSize: responsiveWidth(context, 14.0),
                    color: const Color(0xFF3B3B3B).withOpacity(0.5),
                    height: 1.5,
                  ),
                ),
              ),
              SizedBox(height: responsiveHeight(context, 24.0)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: responsiveWidth(context, 16.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Spicy',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: responsiveWidth(context, 12.0),
                        color: const Color(0xFF838383),
                      ),
                    ),
                    Text(
                      'Quantity',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: responsiveWidth(context, 12.0),
                        color: const Color(0xFF838383),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: responsiveWidth(context, 16.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: responsiveHeight(context, 50.0),
                          width: responsiveWidth(context, 200.0),
                          child: Slider(
                            value: _spiciness,
                            min: 0.0,
                            max: 1.0,
                            onChanged: (value) {
                              setState(() {
                                _spiciness = value;
                              });
                            },
                            activeColor: Colors.red,
                            inactiveColor: Colors.grey[300],
                          ),
                        ),
                        SizedBox(
                          width: responsiveWidth(context, 200.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Spicy',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                  fontSize: responsiveWidth(context, 16.0),
                                  color: const Color(0xFF391713),
                                ),
                              ),
                              Text(
                                _spiciness < 0.33
                                    ? 'Mild'
                                    : _spiciness < 0.66
                                    ? 'Medium'
                                    : 'Hot',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                  fontSize: responsiveWidth(context, 16.0),
                                  color: const Color(0xFF391713),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (_quantity > 1) {
                              setState(() {
                                _quantity--;
                              });
                            }
                          },
                          child: Container(
                            width: responsiveWidth(context, 24.0),
                            height: responsiveHeight(context, 24.0),
                            decoration: const BoxDecoration(
                              color: Color(0xFF3E6898),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.remove,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                        SizedBox(width: responsiveWidth(context, 12.0)),
                        Text(
                          _quantity.toString(),
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            fontSize: responsiveWidth(context, 16.0),
                            color: const Color(0xFF391713),
                          ),
                        ),
                        SizedBox(width: responsiveWidth(context, 12.0)),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _quantity++;
                            });
                          },
                          child: Container(
                            width: responsiveWidth(context, 24.0),
                            height: responsiveHeight(context, 24.0),
                            decoration: const BoxDecoration(
                              color: Color(0xFF3E6898),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: responsiveHeight(context, 150.0)),
              Center(
                child: CustomButton(
                  buttonName: "Add To Cart",
                  onTap: _addToCart,
                ),
              ),
              SizedBox(height: responsiveHeight(context, 20.0)),
            ],
          ),
        ),
      ),
    );
  }
}