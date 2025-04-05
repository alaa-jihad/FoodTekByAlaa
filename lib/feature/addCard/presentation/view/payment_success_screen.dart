import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/constants/png.dart';
import '../../../../core/utils/responsive.dart';
import 'package:foodtek_app/core/constants/color.dart';
import '../../../cart/domain/entity/cart_entity.dart';
import '../../../track/presentation/view/track_screen.dart'; // Import TrackScreen for navigation

class PaymentSuccessScreen extends StatefulWidget {
  final List<CartItem> cartItems; // Pass cartItems for TrackScreen
  final LatLng? selectedLocation; // Pass selectedLocation for TrackScreen
  final String locationUrl; // Pass locationUrl for TrackScreen

  const PaymentSuccessScreen({
    super.key,
    required this.cartItems,
    required this.selectedLocation,
    required this.locationUrl,
  });

  @override
  State<PaymentSuccessScreen> createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0, end: 20).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _confettiController = ConfettiController(duration: const Duration(seconds: 10));
    _confettiController.play();

    // Auto-navigate to TrackScreen after 5 seconds
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => TrackScreen(
            cartItems: widget.cartItems,
            initialLocation: widget.selectedLocation,
            onLocationSelected: (latLng, url) {
              // Handle location selection if needed
            },
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background to white
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Checkout',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            fontSize: 24,
            color: Color(0xFF0A0D13),
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Confetti Animation (Full Screen)
          ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive, // Confetti explodes outward
            shouldLoop: true, // Loop the animation
            colors: [
              Colors.yellow,
              COLORs.blue1,
              Colors.red,
              COLORs.gray2,
              Colors.white,
            ], // Match the image's confetti colors
            numberOfParticles: 50, // Number of confetti pieces
            gravity: 0.1, // Adjust gravity for falling effect
          ),
          // Main Content
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: responsiveHeight(context, 150)),
                Container(
                  margin: const EdgeInsets.only(top: 150),
                  padding: const EdgeInsets.all(24),
                  width: responsiveWidth(context, 343),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Animated Balloon with Device and Plant
                      AnimatedBuilder(
                        animation: _animation,
                        builder: (context, child) {
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              // Balloons (Background)
                              Transform.translate(
                                offset: Offset(0, _animation.value), // Move up and down
                                child: Image.asset(
                                  PNGs.balloons,
                                  width: responsiveWidth(context, 360),
                                  height: responsiveHeight(context, 180),
                                ),
                              ),
                              // Device (Centered on Balloons)
                              Image.asset(
                                PNGs.device,
                                width: responsiveWidth(context, 130),
                                height: responsiveHeight(context, 130),
                              ),
                              // Plant (Positioned to the right)
                              Positioned(
                                right: -responsiveWidth(context, 20), // Adjust position to match image
                                top: responsiveHeight(context, 60), // Adjust to align with image
                                child: Image.asset(
                                  PNGs.plant,
                                  width: responsiveWidth(context, 80),
                                  height: responsiveHeight(context, 100),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 40),
                      // "Your Order Done Successfully" text
                      const Text(
                        'Your Order Done Successfully',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
                          color: Color(0xFF0A0D13),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      // "thank you for using our services within 12min." text
                      const Text(
                        'thank you for using our services within 12min.',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Color(0xFF606060),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      // "Track Your Order" Button
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TrackScreen(
                                cartItems: widget.cartItems,
                                initialLocation: widget.selectedLocation,
                                onLocationSelected: (latLng, url) {
                                  // Handle location selection if needed
                                },
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          height: 57,
                          decoration: BoxDecoration(
                            color: const Color(0xFF3E6898),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text(
                              'Track Your Order',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: responsiveHeight(context, 20)),
                // Home Indicator
                Container(
                  width: responsiveWidth(context, 428.1),
                  height: responsiveHeight(context, 38.81),
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: responsiveWidth(context, 148),
                    height: responsiveHeight(context, 5),
                    margin: const EdgeInsets.only(bottom: 7.81),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(100),
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
}