import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../feature/filter_screen/presentation/view/filter_screen.dart';
import '../../constants/svg.dart';
import '../../constants/color.dart';
import '../../utils/responsive.dart';


class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  _CustomSearchBarState createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: responsiveWidth(context, 370.0),
      height: responsiveHeight(context, 42.0),
      child: TextField(
        controller: _searchController,
        onChanged: (value) {},
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: responsiveHeight(context, 12.0),
            horizontal: responsiveWidth(context, 16.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(responsiveWidth(context, 40.0)),
            borderSide: const BorderSide(color: Color(0xFFD6D6D6), width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(responsiveWidth(context, 40.0)),
            borderSide: const BorderSide(color: Color(0xFFD6D6D6), width: 1.0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(responsiveWidth(context, 40.0)),
            borderSide: const BorderSide(color: Color(0xFFD6D6D6), width: 1.0),
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.only(
              left: responsiveWidth(context, 16.0),
              right: responsiveWidth(context, 8.0),
            ),
            child: SvgPicture.asset(
              SVGs.search,
              width: responsiveWidth(context, 18.0),
              height: responsiveHeight(context, 18.0),
              colorFilter: const ColorFilter.mode(
                Color(0xFF878787),
                BlendMode.srcIn,
              ),
            ),
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 0,
            minHeight: 0,
          ),
          suffixIcon: GestureDetector(
            onTap: () async {
              // Navigate to the FilterScreen and wait for the result
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FilterScreen()),
              );
              if (result != null) {
                print('Filter values: $result');
                // Handle the filter values here
              }
            },
            child: Padding(
              padding: EdgeInsets.only(
                right: responsiveWidth(context, 16.0),
                left: responsiveWidth(context, 8.0),
              ),
              child: SvgPicture.asset(
                SVGs.equalizer,
                width: responsiveWidth(context, 18.0),
                height: responsiveHeight(context, 18.0),
                colorFilter: const ColorFilter.mode(
                  Color(0xFF878787),
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          suffixIconConstraints: const BoxConstraints(
            minWidth: 0,
            minHeight: 0,
          ),
          hintText: "Search menu, restaurant or etc",
          hintStyle: TextStyle(
            fontFamily: 'Inter',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,
            fontSize: responsiveWidth(context, 12.0),
            height: 1.5,
            color: const Color(0xFF878787),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}