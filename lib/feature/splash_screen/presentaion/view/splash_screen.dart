import 'package:flutter/material.dart';
import 'package:foodtek_app/core/constants/png.dart';
import 'package:foodtek_app/core/utils/responsive.dart';
import 'package:foodtek_app/feature/onboarding/presentaion/view/onboarding1_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.elasticOut);
    _controller.forward();
    Future.delayed(const Duration(milliseconds: 2500), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Onboarding1Screen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Image.asset(
              PNGs.backgroundImage,
              width: responsiveWidth(context, 430),
              height: responsiveHeight(context, 932),
              fit: BoxFit.cover,
            ),
            Positioned(
              left: responsiveWidth(context, 71),
              top: responsiveHeight(context, 415),
              child: ScaleTransition(
                scale: _animation,
                child: Image.asset(
                  PNGs.foodtecLogoPng,
                  width: responsiveWidth(context, 307),
                  height: responsiveHeight(context, 85),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}