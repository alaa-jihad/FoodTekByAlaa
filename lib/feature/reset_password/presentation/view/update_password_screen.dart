import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import '../../../../core/constants/png.dart';
import '../../../../core/utils/responsive.dart';
import 'package:foodtek_app/core/constants/color.dart';
import '../../../sign_in/presentation/view/signin_screen.dart';
class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({super.key});

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen>
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

    // Auto-close after 5 seconds
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SigninScreen(),));
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
      body: Stack(
        children: [
          // Background Image
          Container(
            width: responsiveWidth(context, 430),
            height: responsiveHeight(context, 932),
            child: Image.asset(
              PNGs.updatePasswordBackground,
              fit: BoxFit.fill,
            ),
          ),
          // Blur Overlay
          Container(
            width: responsiveWidth(context, 430),
            height: responsiveHeight(context, 932),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                color: Colors.black.withOpacity(0.65),
              ),
            ),
          ),
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
                      // Add "Congratulations!" text
                      Text(
                        'Congratulations!',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          fontSize: 32,
                          height: 1.3, // Line height 130%
                          letterSpacing: -0.02 * 32, // -0.02em
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      // Add "password reset successfully" text
                      Text(
                        'password reset successfully',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          fontSize: 22,
                          height: 1.4, // Line height 140%
                          letterSpacing: -0.01 * 24, // -0.01em
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
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
                      color: Colors.transparent,
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