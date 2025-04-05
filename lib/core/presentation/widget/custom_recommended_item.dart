import 'package:flutter/material.dart';
import 'package:foodtek_app/feature/home/domain/entity/recommended_item.dart'; // Import the domain entity
import '../../../../core/constants/color.dart';
import '../../../../core/utils/responsive.dart';

class CustomRecommended extends StatelessWidget {
  final List<RecommendedItem> items;

  const CustomRecommended({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: responsiveHeight(context, 157.0), // From CSS: height: 157px
      child: Column(
        children: [
          // Header: Recommended and View All
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recommended',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: responsiveWidth(context, 16.0), // From CSS: font-size: 16px
                  color: Color(0xFF391713), // From CSS: color: #391713
                  height: 19 / 16, // line-height: 19px / font-size: 16px
                ),
              ),
              Row(
                children: [
                  Text(
                    'View All',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: responsiveWidth(context, 12.0), // From CSS: font-size: 12px
                      color: Color(0xFF3E6898), // From CSS: color: #3E6898
                      height: 15 / 12, // line-height: 15px / font-size: 12px
                    ),
                  ),
                  SizedBox(width: responsiveWidth(context, 13.0)), // Gap: 13px
                  Transform.rotate(
                    angle: 0, // No rotation needed since the arrow should point right
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: responsiveWidth(context, 8.0), // From CSS: width: 8px
                      color: Color(0xFF3E6898), // From CSS: border: 2px solid #3E6898
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: responsiveHeight(context, 29.0)), // From CSS: top: 29px for the list
          // Horizontal List of Recommended Items
          Container(
            height: responsiveHeight(context, 108.0), // From CSS: height: 108px
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Padding(
                  padding: EdgeInsets.only(right: responsiveWidth(context, 27.5)), // Gap between items: 27.5px
                  child: _buildRecommendedCard(context, item),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendedCard(BuildContext context, RecommendedItem item) {
    return Stack(
      children: [
        // Image Container
        Container(
          width: responsiveWidth(context, 72.0), // From CSS: width: 72px
          height: responsiveHeight(context, 108.0), // From CSS: height: 108px
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(responsiveWidth(context, 19.115)), // From CSS: border-radius: 19.115px
            image: DecorationImage(
              image: AssetImage(item.imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Price Tag
        Positioned(
          bottom: responsiveHeight(context, 20.0), // From CSS: padding: 20px 0px (bottom alignment)
          right: 0,
          child: Container(
            width: responsiveWidth(context, 38.0), // From CSS: width: 38px
            height: responsiveHeight(context, 16.0), // From CSS: height: 16px
            decoration: BoxDecoration(
              color: Color(0xFF3E6898), // From CSS: background: #3E6898
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(responsiveWidth(context, 30.0)),
                bottomLeft: Radius.circular(responsiveWidth(context, 30.0)),
              ), // From CSS: border-radius: 30px 0px 0px 30px
            ),
            child: Center(
              child: Text(
                item.price,
                style: TextStyle(
                  fontFamily: 'League Spartan',
                  fontWeight: FontWeight.w400,
                  fontSize:12.0, // From CSS: font-size: 12px
                  color: Colors.white, // From CSS: color: #FFFFFF
                  //height: 11 / 12, // line-height: 11px / font-size: 12px
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}