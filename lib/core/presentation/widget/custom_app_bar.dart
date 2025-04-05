import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/color.dart';
import '../../utils/responsive.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String locationTitle;
  final String locationName;
  final Color preColor;
  final Color suffixColor; // Fixed typo in variable name
  final String preIcon;
  final String suffixIcon;
  final double appBarHeight;
  final VoidCallback? onNotificationTap; // Add callback for notification tap

  const CustomAppBar({
    super.key,
    required this.locationTitle,
    required this.locationName,
    required this.preColor,
    required this.suffixColor,
    required this.preIcon,
    required this.suffixIcon,
    required this.appBarHeight,
    this.onNotificationTap, // Add to constructor
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: appBarHeight,
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Container(
        width: responsiveWidth(context, 367.0),
        height: responsiveHeight(context, 41.0),
        margin: const EdgeInsets.only(left: 14.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Location Section (unchanged)
            SizedBox(
              width: responsiveWidth(context, 222.0),
              height: responsiveHeight(context, 41.0),
              child: Row(
                children: [
                  Container(
                    width: responsiveWidth(context, 34.0),
                    height: responsiveHeight(context, 34.0),
                    padding: EdgeInsets.all(responsiveWidth(context, 8.0)),
                    decoration: BoxDecoration(
                      color: preColor,
                      borderRadius: BorderRadius.circular(responsiveWidth(context, 4.0)),
                    ),
                    child: SvgPicture.asset(
                      preIcon,
                      width: responsiveWidth(context, 18.0),
                      height: responsiveHeight(context, 18.0),
                      colorFilter: const ColorFilter.mode(
                        COLORs.blue1,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  SizedBox(width: responsiveWidth(context, 10.0)),
                  SizedBox(
                    width: responsiveWidth(context, 178.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Text(
                              locationTitle,
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                fontSize: responsiveWidth(context, 12.0),
                                height: 1.5,
                                letterSpacing: responsiveWidth(context, 0.16),
                                color: COLORs.neutral70,
                              ),
                            ),
                            SizedBox(width: responsiveWidth(context, 4.0)),
                            Icon(
                              Icons.arrow_drop_down,
                              size: responsiveWidth(context, 18.0),
                              color: COLORs.neutral70,
                            ),
                          ],
                        ),
                        SizedBox(height: responsiveHeight(context, 4.0)),
                        Text(
                          locationName,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            fontSize: responsiveWidth(context, 14.0),
                            height: 1.2,
                            color: COLORs.neutral100,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Notification Section with Tap Handler
            GestureDetector(
              onTap: onNotificationTap, // Trigger callback on tap
              child: Container(
                width: responsiveWidth(context, 34.0),
                height: responsiveHeight(context, 34.0),
                padding: EdgeInsets.all(responsiveWidth(context, 8.0)),
                decoration: BoxDecoration(
                  color: suffixColor,
                  borderRadius: BorderRadius.circular(responsiveWidth(context, 4.0)),
                ),
                child: Stack(
                  children: [
                    SvgPicture.asset(
                      suffixIcon,
                      width: responsiveWidth(context, 18.0),
                      height: responsiveHeight(context, 18.0),
                      colorFilter: const ColorFilter.mode(
                        COLORs.neutral100,
                        BlendMode.srcIn,
                      ),
                    ),
                    Positioned(
                      left: responsiveWidth(context, 18.0 * 0.6111),
                      top: responsiveHeight(context, 18.0 * 0.0556),
                      child: Container(
                        width: responsiveWidth(context, 6.0),
                        height: responsiveHeight(context, 6.0),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: COLORs.redDot,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);
}