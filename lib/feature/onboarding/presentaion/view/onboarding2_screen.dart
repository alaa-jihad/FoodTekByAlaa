import 'package:flutter/material.dart';
import 'package:foodtek_app/core/constants/png.dart';
import 'package:foodtek_app/feature/onboarding/presentaion/view/widgets/onboarding_widget.dart';

import '../../../../core/constants/color.dart';
import '../../../../core/utils/responsive.dart';
import 'onboarding3_screen.dart';
import 'onboarding4_screen.dart';
class Onboarding2Screen extends StatelessWidget {
  const Onboarding2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingWidget(
      height: responsiveHeight(context, 939),
      width: responsiveWidth(context, 430),
      backgroundImage: PNGs.pattern,
      sizedbox: SizedBox(height: responsiveHeight(context, 115),),
      image:Image.asset(
        PNGs.imageTwo,
        width: responsiveWidth(context, 313),
        height: responsiveHeight(context, 220),),
      title:'Get Delivery On Time ',
      description: "Order Your Favorite Food Within The \nPlam Of Your Hand And The Zone \nOf Your Comfort",
      buttonName: "Continue",
      onNext:(){
        //Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) => Onboarding3Screen(),));
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 1000),
            pageBuilder: (context, animation, secondaryAnimation) =>
            const Onboarding3Screen(),
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
      currentIndex: 1,
      totalDots: 3,
      color: COLORs.blue3,
      textColor: COLORs.white,
      onSkip: (){
        //Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Onboarding4Screen(),));
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
