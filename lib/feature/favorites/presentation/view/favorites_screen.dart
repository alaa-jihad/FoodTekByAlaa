import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodtek_app/core/constants/color.dart';
import 'package:foodtek_app/core/presentation/button/custom_button.dart';
import '../../../../core/constants/svg.dart';
import '../../../../core/presentation/widget/custom_app_bar.dart';
import '../../../../core/presentation/widget/custom_search_bar.dart';
import '../../../../core/presentation/widget/select_category.dart';
import '../../../../core/utils/responsive.dart';
import '../../../home/domain/entity/select_category_item.dart';
import '../../../notification/domain/entity/notification_item.dart';
import '../../../notification/presentation/view/notification_screen.dart';
import '../cubit/fav_cubit.dart';
import '../state/fav_event.dart';
import '../state/fav_state.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(14.0, 16.0, 14.0, 16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: responsiveHeight(context, 22.0)),
              Center(child: CustomSearchBar()),
              SizedBox(height: responsiveHeight(context, 30.0)),
              Text(
                'Favorites',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: responsiveWidth(context, 20.0),
                  color: const Color(0xFF391713),
                  height: 1.2,
                ),
              ),
              SizedBox(height: responsiveHeight(context, 13)),
              BlocBuilder<FavoritesBloc, FavoritesState>(
                builder: (context, state) {
                  print('FavoritesScreen favoritedItems: ${state.favoritedItems
                      .map((e) => e.title).toList()}');
                  return state.favoritedItems.isEmpty
                      ? const Center(child: Text('No favorites yet!'))
                      : SelectCategory(
                    selectedCategory: 'All',
                    favoritedItems: state.favoritedItems,
                    items: state.favoritedItems,
                    onFavoriteToggle: (item) {
                      _showRemoveConfirmationDialog(context, item);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showRemoveConfirmationDialog(BuildContext context,
      SelectCategoryItem item) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Are you sure you want to remove it from favorites?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Color(0xFF391713),
            ),
          ),
          actions: [
            CustomButton(buttonName: 'Yes',
          onTap: (){
              context.read<FavoritesBloc>().add(ToggleFavorite(item));
          Navigator.of(dialogContext).pop();
        } // Close the dialog})
      ),
          ],
        );
      },
    );
  }
}