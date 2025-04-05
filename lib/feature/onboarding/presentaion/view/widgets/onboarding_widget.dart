import 'package:flutter/material.dart';
import 'package:foodtek_app/core/constants/color.dart';
import 'package:foodtek_app/core/utils/responsive.dart';

class OnboardingWidget extends StatelessWidget {
  final String backgroundImage;
  final Widget image;
  final String title;
  final String description;
  final VoidCallback onNext;
  final VoidCallback? onCancel;
  final VoidCallback? onSkip;
  final String buttonName;
  final int? currentIndex;
  final int? totalDots;
  final Color color;
  final Color textColor;
  final SizedBox? sizedbox;
  final bool showLocationButtons;
  final double height;
  final double width;

  const OnboardingWidget({
    super.key,
    required this.backgroundImage,
    required this.image,
    required this.title,
    required this.description,
    required this.buttonName,
    required this.onNext,
    required this.height,
    required this.width,
    this.onCancel,
    this.onSkip,
    this.currentIndex,
    this.totalDots,
    required this.color,
    required this.textColor,
    this.sizedbox,
    this.showLocationButtons = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLORs.white,
      body: Container(
        height: responsiveHeight(context, height),
        width: responsiveWidth(context, width),
        child: Stack(
          children: [
            ShaderMask(
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white, Colors.transparent],
                  stops: [0.5, 1.0],
                ).createShader(bounds);
              },
              blendMode: BlendMode.dstIn,
              child: Container(
                height: responsiveHeight(context, 300),
                width: responsiveWidth(context, double.infinity),
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage(backgroundImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  if (showLocationButtons)
                    SizedBox(height: responsiveHeight(context, 120)),
                  if (sizedbox != null)
                    SizedBox(height: responsiveHeight(context, 115)),
                  if (!showLocationButtons)
                    SizedBox(height: responsiveHeight(context, 150)), // Reduced from 155 to 150
                  image,
                  SizedBox(height: responsiveHeight(context, 16)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 48),
                    child: Column(
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 31,
                            fontWeight: FontWeight.w500,
                            color: COLORs.textColor,
                            height: 1.22,
                          ),
                        ),
                        SizedBox(height: responsiveHeight(context, 16)),
                        Text(
                          description,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: COLORs.textColor,
                            letterSpacing: -0.16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: responsiveHeight(context, 50)), // Reduced from 55 to 50
                  if (showLocationButtons)
                    SizedBox(height: responsiveHeight(context, 35)),
                  if (!showLocationButtons)
                    SizedBox(height: responsiveHeight(context, 60)), // Reduced from 65 to 60
                  Container(
                    width: responsiveWidth(context, 307),
                    height: responsiveHeight(context, 47),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [COLORs.blue1, COLORs.blue3],
                        stops: [0, 1],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(69),
                    ),
                    child: TextButton(
                      onPressed: onNext,
                      child: Text(
                        buttonName,
                        style: TextStyle(
                          color: COLORs.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  if (showLocationButtons) ...[
                    SizedBox(height: responsiveHeight(context, 16)),
                    Container(
                      width: responsiveWidth(context, 307),
                      height: responsiveHeight(context, 47),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(69),
                      ),
                      child: TextButton(
                        onPressed: onCancel ?? () {},
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: COLORs.textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                  SizedBox(height: responsiveHeight(context, 55)), // Reduced from 60 to 55
                  if (!showLocationButtons)
                    Padding(
                      padding: const EdgeInsets.only(left: 44, right: 53),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (onSkip != null)
                            TextButton(
                              onPressed: onSkip,
                              child: Text(
                                'Skip',
                                style: TextStyle(
                                  color: COLORs.darkBlue,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(totalDots!, (index) {
                              return Container(
                                width: responsiveWidth(context, 10),
                                height: responsiveHeight(context, 10),
                                margin: EdgeInsets.symmetric(horizontal: 4),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: index == currentIndex
                                      ? COLORs.blue1
                                      : COLORs.undots,
                                ),
                              );
                            }),
                          ),
                          Icon(
                            Icons.arrow_forward_sharp,
                            size: 24,
                            color: COLORs.blue1,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}