import 'package:flutter/material.dart';
import '../../constants/color.dart';
import '../../utils/responsive.dart';

class PromoBanner extends StatelessWidget {
  final String title;
  final String discount;
  final String imagePath;

  const PromoBanner({
    super.key,
    required this.title,
    required this.discount,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final double borderRadiusValue = responsiveWidth(context, 8.0);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Main container (Frame 71)
        Container(
          width: responsiveWidth(context, 370.0),
          height: responsiveHeight(context, 128.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadiusValue),
            border: Border.all(
              color: COLORs.grey, // You can change this color as needed
              width: 2.0, // Adjust the border width as needed
            ),
          ),
          child: ClipRRect(
            // Clip the children to respect the border radius of the main container
            borderRadius: BorderRadius.circular(borderRadiusValue),
            child: Stack(
              children: [
                // Background with rounded corners and shadow (Vector)
                Positioned(
                  right: responsiveWidth(context, 5.0),
                  bottom: responsiveHeight(context, -4.0),
                  child: Container(
                    width: responsiveWidth(context, 370.0),
                    height: responsiveHeight(context, 141.0),
                    decoration: BoxDecoration(
                      color: COLORs.blue1, // Background color #3E6898
                      borderRadius: BorderRadius.circular(borderRadiusValue),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFD7D7D7), // Shadow color #D7D7D7
                          blurRadius: 4.0,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                  ),
                ),
                // Image on the right (Photo Pizza)
                Positioned(
                  left: responsiveWidth(context, 180.0),
                  top: 0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(borderRadiusValue),
                      bottomRight: Radius.circular(borderRadiusValue),
                    ),
                    child: Image.asset(
                      imagePath,
                      width: responsiveWidth(context, 211.0),
                      height: responsiveHeight(context, 141.0),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Text: "Experience our delicious new dish"
                Positioned(
                  left: responsiveWidth(context, 370.0 * 0.0189), // 1.89%
                  right: responsiveWidth(context, 370.0 * 0.60), // 60%
                  top: responsiveHeight(context, 128.0 * 0.1898), // Adjusted for new height (128px)
                  child: Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      fontSize: responsiveWidth(context, 16.0),
                      height: 1.1875, // 19px / 16px
                      color: COLORs.whitef4, // #F8F8F8
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                // Text: "30% OFF"
                Positioned(
                  left: responsiveWidth(context, 370.0 * 0.0378), // 3.78%
                  right: responsiveWidth(context, 370.0 * 0.6189), // 61.89%
                  top: responsiveHeight(context, 128.0 * 0.5255), // Adjusted for new height (128px)
                  child: Text(
                    discount,
                    style: TextStyle(
                      fontFamily: 'League Spartan',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w700,
                      fontSize: responsiveWidth(context, 29.0),
                      height: 0.927, // 29px / 32px
                      color: COLORs.whitef4, // #F8F8F8
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                // Ellipse 13 (top circle)
                Positioned(
                  left: responsiveWidth(context, 106.0),
                  top: responsiveHeight(context, -37.0),
                  child: Container(
                    width: responsiveWidth(context, 55.0),
                    height: responsiveHeight(context, 55.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFFFCC4D), // Yellow border #FFCC4D
                        width: responsiveWidth(context, 8.0),
                      ),
                    ),
                  ),
                ),
                // Ellipse 12 (bottom circle)
                Positioned(
                  left: responsiveWidth(context, -14.0),
                  top: responsiveHeight(context, 105.0),
                  child: Container(
                    width: responsiveWidth(context, 46.0),
                    height: responsiveHeight(context, 46.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFFFCC4D), // Yellow border #FFCC4D
                        width: responsiveWidth(context, 8.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}