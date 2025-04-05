import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodtek_app/core/presentation/widget/custom_app_bar.dart';
import 'package:foodtek_app/core/presentation/widget/custom_search_bar.dart';
import 'package:foodtek_app/feature/home/domain/entity/top_rated_item.dart';
import 'package:foodtek_app/feature/home/domain/entity/recommended_item.dart';
import 'package:foodtek_app/feature/home/domain/entity/select_category_item.dart';
import 'package:foodtek_app/core/presentation/widget/select_category.dart';
import '../../../../core/constants/color.dart';
import '../../../../core/constants/jpg.dart';
import '../../../../core/constants/svg.dart';
import '../../../../core/presentation/widget/category_filter.dart';
import '../../../../core/presentation/widget/custom_banner.dart';
import '../../../../core/presentation/widget/custom_recommended_item.dart';
import '../../../../core/presentation/widget/custom_top_rated.dart';
import '../../../../core/utils/responsive.dart';
import '../../../favorites/presentation/cubit/fav_cubit.dart';
import '../../../favorites/presentation/state/fav_event.dart';
import '../../../favorites/presentation/state/fav_state.dart';
import '../../../notification/domain/entity/notification_item.dart';
import '../../../notification/presentation/view/notification_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, String>> banners = [
    {
      'title': 'Experience our delicious new dish',
      'discount': '30% OFF',
      'image': JPGs.pizza,
    },
    {
      'title': 'Try our tasty new pizza',
      'discount': '25% OFF',
      'image': JPGs.burger,
    },
    {
      'title': 'Savor our fresh pasta',
      'discount': '20% OFF',
      'image': JPGs.sandwihes1,
    },
    {
      'title': 'Enjoy our gourmet burgers',
      'discount': '15% OFF',
      'image': JPGs.chicken,
    },
    {
      'title': 'Taste our new dessert',
      'discount': '10% OFF',
      'image': JPGs.sandwihes2,
    },
  ];

  final List<TopRatedItem> topRatedItems = [
    TopRatedItem(
      rating: 3.8,
      imagePath: JPGs.chicken,
      title: 'Chicken burger',
      description: 'Nulla occaecat velit laborum exercitation ullamco. Elit labore eu aute elit nostrud culpa velit excepteur deserunt sunt. Velit non est cillum consequat cupidatat ex Lorem laboris labore aliqua ad duis eu laborum.',
      price: '\$20.00',
    ),
    TopRatedItem(
      rating: 4.5,
      imagePath: JPGs.burger,
      title: 'Cheese burger',
      description: '100 gr meat + onion + tomato + Lettuce cheese',
      price: '\$15.00',
    ),
    TopRatedItem(
      rating: 3.8,
      imagePath: JPGs.chicken,
      title: 'Chicken burger',
      description: '100 gr chicken + tomato + cheese Lettuce',
      price: '\$20.00',
    ),
  ];

  final List<RecommendedItem> recommendedItems = [
    RecommendedItem(
      imagePath: JPGs.sandwihes1,
      price: '\$103.0',
    ),
    RecommendedItem(
      imagePath: JPGs.chicken,
      price: '\$50.0',
    ),
    RecommendedItem(
      imagePath: JPGs.pizza,
      price: '\$12.99',
    ),
    RecommendedItem(
      imagePath: JPGs.sandwihes2,
      price: '\$8.20',
    ),
  ];

  final List<SelectCategoryItem> selectCategoryItems = [
    SelectCategoryItem(
      category: 'Pizza',
      title: 'Pepperoni pizza',
      description: 'Pepperoni pizza, Margarita Pizza Margherita Italian cuisine Tomato',
      price: '\$29',
      imagePath: JPGs.pizza,
    ),
    SelectCategoryItem(
      category: 'Pizza',
      title: 'Pizza Cheese',
      description: 'Food pizza dish cuisine junk food, Fast Food, Flatbread, Ingredient',
      price: '\$23',
      imagePath: JPGs.pizza,
    ),
    SelectCategoryItem(
      category: 'Pizza',
      title: 'Peppy Paneer',
      description: 'Chunky paneer with crisp capsicum and spicy red pepper',
      price: '\$13',
      imagePath: JPGs.pizza,
    ),
    SelectCategoryItem(
      category: 'Pizza',
      title: 'Mexican Green Wave',
      description: 'A pizza loaded with crunchy onions, crisp capsicum, juicy tomatoes',
      price: '\$23',
      imagePath: JPGs.pizza,
    ),
    SelectCategoryItem(
      category: 'Burger',
      title: 'Chicken Burger',
      description: '100 gr chicken + tomato + cheese Lettuce',
      price: '\$20',
      imagePath: JPGs.burger,
    ),
    SelectCategoryItem(
      category: 'Burger',
      title: 'Cheese Burger',
      description: '100 gr meat + onion + tomato + Lettuce cheese',
      price: '\$15',
      imagePath: JPGs.burger,
    ),
    SelectCategoryItem(
      category: 'Sandwich',
      title: 'Club Sandwich',
      description: 'Ham, cheese, lettuce, tomato, mayo',
      price: '\$10',
      imagePath: JPGs.sandwihes1,
    ),
    SelectCategoryItem(
      category: 'Sandwich',
      title: 'Veggie Sandwich',
      description: 'Cucumber, tomato, lettuce, avocado',
      price: '\$8',
      imagePath: JPGs.sandwihes2,
    ),
  ];

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

  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;
  String _selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < banners.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _onCategorySelected(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  void _showNotificationBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows the bottom sheet to take more height
      builder: (context) => NotificationBottomSheet(notifications: notifications),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLORs.white,
      appBar: CustomAppBar(
        preColor: COLORs.appbar,
        preIcon: SVGs.appbar_location,
        locationTitle: "Current location",
        locationName: "Jl. Soekarno Hatta 15A..",
        suffixColor: COLORs.suffixIcon, // Fixed typo
        suffixIcon: SVGs.appbar_notification,
        appBarHeight: responsiveHeight(context, 41.0),
        onNotificationTap: _showNotificationBottomSheet, // Pass the callback
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
              FilterCategory(onCategorySelected: _onCategorySelected),
              SizedBox(height: responsiveHeight(context, 22.0)),
              if (_selectedCategory == 'All') ...[
                Container(
                  height: responsiveHeight(context, 137.0),
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: banners.length,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: responsiveWidth(context, 16.0),
                        ),
                        child: PromoBanner(
                          title: banners[index]['title']!,
                          discount: banners[index]['discount']!,
                          imagePath: banners[index]['image']!,
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(banners.length, (index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: responsiveWidth(context, 4.0)),
                      width: responsiveWidth(context, 20.0),
                      height: responsiveHeight(context, 4.0),
                      decoration: BoxDecoration(
                        color: _currentPage == index ? COLORs.blue1 : COLORs.bluebottom,
                        borderRadius: BorderRadius.circular(responsiveWidth(context, 12.0)),
                      ),
                    );
                  }),
                ),
                SizedBox(height: responsiveHeight(context, 5.0)),
                Text(
                  'Top Rated',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: responsiveWidth(context, 20.0),
                    color: Color(0xFF391713),
                    height: 1.2,
                  ),
                ),
                SizedBox(height: responsiveHeight(context, 13.0)),
                CustomTopRated(items: topRatedItems),
                SizedBox(height: responsiveHeight(context, 15.0)),
                CustomRecommended(items: recommendedItems),
                SizedBox(height: responsiveHeight(context, 15.0)),
              ] else ...[
                BlocBuilder<FavoritesBloc, FavoritesState>(
                  builder: (context, state) {
                    return SelectCategory(
                      selectedCategory: _selectedCategory,
                      favoritedItems: state.favoritedItems,
                      items: selectCategoryItems,
                      onFavoriteToggle: (item) {
                        context.read<FavoritesBloc>().add(ToggleFavorite(item));
                      },
                    );
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}