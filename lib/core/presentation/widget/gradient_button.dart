import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/color.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final GestureTapCallback onTap;
  final double height;
  final double width;
  final Color color;
  const GradientButton({
    super.key,
    required this.text,
    required this.onTap,
    required this.height,
    required this.width,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints(minHeight: height, minWidth: width),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color:COLORs.blue1
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontFamily: 'AvenirArabic',
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}
