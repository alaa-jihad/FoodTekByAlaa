import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodtek_app/core/constants/png.dart';
import 'package:foodtek_app/feature/favorites/presentation/view/favorites_screen.dart';
import 'package:foodtek_app/feature/profile/presentaion/view/profile_screen.dart';
import 'package:foodtek_app/feature/track/presentation/view/track_screen.dart';
import 'package:foodtek_app/core/constants/color.dart';
import 'package:foodtek_app/core/constants/svg.dart';
import 'package:foodtek_app/feature/cart/domain/entity/cart_entity.dart';
import 'package:foodtek_app/feature/cart/presentation/view/cart_screen.dart';
import 'package:foodtek_app/feature/home/presentation/view/home_screen.dart';
import 'package:foodtek_app/feature/checkout/presentation/view/checkout_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MainScreen extends StatefulWidget {
  final int selectedIndex;
  final LatLng? selectedLocation;
  final String? locationUrl;
  final List<CartItem>? cartItems;

  const MainScreen({
    super.key,
    this.selectedIndex = 0,
    this.selectedLocation,
    this.locationUrl,
    this.cartItems,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late Widget selectedWidget;
  late int selectedIndex;
  LatLng? selectedLocation;
  String? locationUrl;
  List<CartItem>? cartItems;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;
    selectedLocation = widget.selectedLocation;
    locationUrl = widget.locationUrl;
    cartItems = widget.cartItems;
    _selectWidget(selectedIndex);
  }

  void _selectWidget(int index) {
    setState(() {
      selectedIndex = index;
      if (selectedIndex == 0) {
        selectedWidget = const HomeScreen();
      } else if (selectedIndex == 1) {
        selectedWidget = const FavoritesScreen();
      } else if (selectedIndex == 2) {
        if (selectedLocation != null && locationUrl != null && cartItems != null) {
          selectedWidget = CheckoutScreen(
            selectedLocation: selectedLocation,
            locationUrl: locationUrl!,
            cartItems: cartItems!,
            onChangeLocation: () {
              _selectWidget(3); // Navigate to TrackScreen
            },
            onOrderPlaced: () {
              setState(() {
                selectedLocation = null;
                locationUrl = null;
                cartItems = [];
                selectedWidget = CartScreen();
              });
            },
          );
        } else {
          selectedWidget = CartScreen();
        }
      } else if (selectedIndex == 3) {
        selectedWidget = TrackScreen(
          onLocationSelected: (LatLng? latLng, String url) {
            if (latLng != null) {
              setState(() {
                selectedLocation = latLng;
                locationUrl = url;
                cartItems = cartItems ?? [];
                selectedIndex = 2; // Switch to Cart tab
                _selectWidget(selectedIndex);
              });
            }
          },
          initialLocation: selectedLocation,
          cartItems: cartItems,
        );
      } else if (selectedIndex == 4) {
        selectedWidget = const ProfileScreen();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: selectedWidget,
      bottomNavigationBar: Container(
        width: 430,
        height: 100,
        margin: const EdgeInsets.only(bottom: 3),
        decoration: const BoxDecoration(
          color: COLORs.bluebottom,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: COLORs.blue3,
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            BottomNavigationBar(
              onTap: _selectWidget,
              elevation: 0,
              backgroundColor: COLORs.bluebottom,
              currentIndex: selectedIndex,
              selectedItemColor: COLORs.blue1,
              unselectedItemColor: COLORs.unselectedColor,
              selectedLabelStyle: const TextStyle(
                fontFamily: 'Cairo',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                height: 22 / 12,
              ),
              unselectedLabelStyle: const TextStyle(
                fontFamily: 'Cairo',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                height: 22 / 12,
              ),
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    SVGs.home,
                    width: 24,
                    height: 24,
                    colorFilter: const ColorFilter.mode(COLORs.unselectedColor, BlendMode.srcIn),
                  ),
                  activeIcon: const SizedBox.shrink(),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    SVGs.favorites,
                    width: 24,
                    height: 24,
                    colorFilter: const ColorFilter.mode(COLORs.unselectedColor, BlendMode.srcIn),
                  ),
                  activeIcon: const SizedBox.shrink(),
                  label: "Favorites",
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    SVGs.cart,
                    width: 24,
                    height: 24,
                    colorFilter: const ColorFilter.mode(COLORs.unselectedColor, BlendMode.srcIn),
                  ),
                  activeIcon: const SizedBox.shrink(),
                  label: "Cart",
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    SVGs.track,
                    width: 24,
                    height: 24,
                    colorFilter: const ColorFilter.mode(COLORs.unselectedColor, BlendMode.srcIn),
                  ),
                  activeIcon: const SizedBox.shrink(),
                  label: "Track",
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    SVGs.profile,
                    width: 24,
                    height: 24,
                    colorFilter: const ColorFilter.mode(COLORs.unselectedColor, BlendMode.srcIn),
                  ),
                  activeIcon: const SizedBox.shrink(),
                  label: "Profile",
                ),
              ],
            ),
            if (selectedIndex == 0)
              Positioned(
                top: -20,
                left: MediaQuery.of(context).size.width / 5 * 0.2,
                child: GestureDetector(
                  onTap: () => _selectWidget(0),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: COLORs.blue1,
                    ),
                    child: SvgPicture.asset(
                      SVGs.home,
                      width: 24,
                      height: 24,
                      colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    ),
                  ),
                ),
              ),
            if (selectedIndex == 1)
              Positioned(
                top: -20,
                left: MediaQuery.of(context).size.width / 4.2 * 1,
                child: GestureDetector(
                  onTap: () => _selectWidget(1),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: COLORs.blue1,
                    ),
                    child: SvgPicture.asset(
                      SVGs.favSelect,
                      width: 24,
                      height: 24,
                      colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    ),
                  ),
                ),
              ),
            if (selectedIndex == 2)
              Positioned(
                top: -20,
                left: MediaQuery.of(context).size.width / 4.5 * 2,
                child: GestureDetector(
                  onTap: () => _selectWidget(2),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: COLORs.blue1,
                    ),
                    child: SvgPicture.asset(
                      SVGs.cart,
                      width: 24,
                      height: 24,
                      colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    ),
                  ),
                ),
              ),
            if (selectedIndex == 3)
              Positioned(
                top: -20,
                left: MediaQuery.of(context).size.width / 4.6 * 3,
                child: GestureDetector(
                  onTap: () => _selectWidget(3),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: COLORs.blue1,
                    ),
                    child: SvgPicture.asset(
                      SVGs.track,
                      width: 24,
                      height: 24,
                      colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    ),
                  ),
                ),
              ),
            if (selectedIndex == 4)
              Positioned(
                top: -20,
                left: MediaQuery.of(context).size.width / 5 * 4.2,
                child: GestureDetector(
                  onTap: () => _selectWidget(4),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: COLORs.blue1,
                    ),
                    child: SvgPicture.asset(
                      SVGs.profile,
                      width: 24,
                      height: 24,
                      colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}