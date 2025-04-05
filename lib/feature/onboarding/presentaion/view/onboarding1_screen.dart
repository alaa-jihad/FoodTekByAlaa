import 'package:flutter/material.dart';
import 'package:foodtek_app/core/constants/png.dart';
import 'package:foodtek_app/feature/onboarding/presentaion/view/onboarding2_screen.dart';
import 'package:foodtek_app/feature/onboarding/presentaion/view/onboarding4_screen.dart';
import 'package:foodtek_app/feature/onboarding/presentaion/view/widgets/onboarding_widget.dart';

import '../../../../core/constants/color.dart';
import '../../../../core/utils/responsive.dart';
class Onboarding1Screen extends StatelessWidget {
  const Onboarding1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingWidget(
      height: responsiveHeight(context, 939),
        width: responsiveWidth(context, 430),
        backgroundImage: PNGs.pattern,
        image:Image.asset(
          PNGs.imageOne,
          width: responsiveWidth(context, 328),
          height: responsiveHeight(context, 355),),
        title:'Welcome To Sahlah',
        description: "Enjoy A Fast And Smooth Food Delivery\n At Your Doorstep",
        buttonName: "Continue",
        onNext:(){
          //Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) => Onboarding2Screen(),));
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 1000),
              pageBuilder: (context, animation, secondaryAnimation) =>
              const Onboarding2Screen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            ),
          );
        },
        currentIndex: 0,
        totalDots: 3,
        color: COLORs.blue3,
        textColor: COLORs.white,
        onSkip: (){
         // Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Onboarding4Screen(),));
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 1000),
              pageBuilder: (context, animation, secondaryAnimation) =>
              const Onboarding4Screen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            ),
          );
          },
    );
  }
}
