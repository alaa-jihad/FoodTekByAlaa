import 'package:flutter/material.dart';
import 'package:foodtek_app/feature/onboarding/presentaion/view/onboarding1_screen.dart';
import 'package:foodtek_app/feature/onboarding/presentaion/view/widgets/onboarding_widget.dart';
import 'package:foodtek_app/feature/sign_in/presentation/view/signin_screen.dart';

import '../../../../core/constants/color.dart';
import '../../../../core/constants/png.dart';
import '../../../../core/utils/responsive.dart';
class Onboarding4Screen extends StatelessWidget {
  const Onboarding4Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingWidget(
      height: responsiveHeight(context, 939),
      width: responsiveWidth(context, 430),
      backgroundImage: PNGs.maps,
      image:Image.asset(
        PNGs.image4,
        width: responsiveWidth(context, 328),
        height: responsiveHeight(context, 355),),
      title:'Turn On Your Location',
      description: "To Continues, Let Your Device Turn\n On Location, Which Uses Google’s \n Location Service",
      buttonName: "Yes, Turn It On",
      onNext:(){
       // Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) => SigninScreen(),));
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 2000),
            pageBuilder: (context, animation, secondaryAnimation) {
              return SigninScreen();
            },
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const curve = Curves.easeInOut;

              var slideTween = Tween<Offset>(
                begin: const Offset(0.0, -1.0),
                end: Offset.zero,
              ).chain(CurveTween(curve: curve));

              var fadeTween = Tween<double>(begin: 0.0, end: 1.0);

              return FadeTransition(
                opacity: animation.drive(fadeTween),
                child: SlideTransition(
                  position: animation.drive(slideTween),
                  child: child,
                ),
              );
            },
          ),
        );
        },
      color: COLORs.blue3,
      textColor: COLORs.white,
      showLocationButtons: true,
     onCancel: (){
        //Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) => Onboarding1Screen(),));
       Navigator.of(context).pushReplacement(
         PageRouteBuilder(
           transitionDuration: const Duration(milliseconds: 1000),
           pageBuilder: (context, animation, secondaryAnimation) =>
           const Onboarding1Screen(),
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
