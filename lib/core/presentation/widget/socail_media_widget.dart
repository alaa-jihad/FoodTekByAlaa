import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodtek_app/core/utils/responsive.dart';
class SocailMediaWidget extends StatefulWidget {
  final String svgIcon;
  final String title;
  final VoidCallback onTap;
  const SocailMediaWidget({super.key,required this.title,required this.svgIcon,required this.onTap});

  @override
  State<SocailMediaWidget> createState() => _SocailMediaWidgetState();
}

class _SocailMediaWidgetState extends State<SocailMediaWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        child: Container(
          width: responsiveWidth(context, 295), // Match CSS width
          height: responsiveHeight(context, 48), // Match CSS height
          padding: EdgeInsets.symmetric(
            vertical: responsiveHeight(context, 10), // Match CSS padding: 10px vertical
            horizontal: responsiveWidth(context, 24), // Match CSS padding: 24px horizontal
          ),
          decoration: BoxDecoration(
            color: Colors.white, // #FFFFFF
            border: Border.all(color: const Color(0xFFEFF0F6)), // #EFF0F6
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFF4F5FA).withOpacity(0.6), // rgba(244, 245, 250, 0.6)
                blurRadius: 6,
                offset: const Offset(0, -3), // Inset shadow approximated as outward offset
              ),
            ],
            borderRadius: BorderRadius.circular(10), // Match CSS border-radius: 10px
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  widget.svgIcon,
                  height: responsiveHeight(context, 18),
                  width: responsiveWidth(context,18),
                ),
                SizedBox(width: responsiveWidth(context, 10),),
                Text(
                  widget.title,
                  style:
                    TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      height: 1.4,
                      letterSpacing: -0.01,
                      color: const Color(0xFF1A1C1E),
                  ),
                )
              ],
            ),
          ),
        ),
        onTap: widget.onTap,
      ),
    );
  }
}
