import 'package:flutter/material.dart';

import '../../constants/color.dart';
import '../../utils/responsive.dart';

class CustomButton extends StatelessWidget {
  final String buttonName;
  final VoidCallback onTap;
  const CustomButton({super.key,required this.buttonName,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: responsiveWidth(context, 295),
        height: responsiveHeight(context, 48),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              COLORs.blue1.withOpacity(0.65),
              COLORs.blue1,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF253EA7).withOpacity(0.48),
              blurRadius: 1,
              offset: const Offset(0, 1),
            ),
            BoxShadow(
              color: const Color(0xFF85DE9E).withOpacity(0.48),
              blurRadius: 1,
              offset: const Offset(0, 0),
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            buttonName,
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              fontSize: 14,
              height: 1.4,
              letterSpacing: -0.01,
              color: COLORs.white,
            ),
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
