import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodtek_app/feature/home/domain/entity/top_rated_item.dart';
import '../../../../core/constants/color.dart';
import '../../../../core/utils/responsive.dart';
import '../../../feature/cart/domain/entity/cart_entity.dart';
import '../../../feature/cart/presentation/cubit/cart_cubit.dart';
import '../../../feature/cart/presentation/state/cart_event.dart';
import '../../../feature/details_screen/presentation/view/details_screen.dart';

class CustomTopRated extends StatelessWidget {
  final List<TopRatedItem> items;

  const CustomTopRated({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: responsiveHeight(context, 209.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Padding(
            padding: EdgeInsets.only(right: responsiveWidth(context, 17.0)),
            child: _buildTopRatedCard(context, item),
          );
        },
      ),
    );
  }

  Widget _buildTopRatedCard(BuildContext context, TopRatedItem item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsScreen(
              imagePath: item.imagePath,
              price: item.price,
              title: item.title,
              description: item.description,
              rating: item.rating,
            ),
          ),
        );
      },
      child: Container(
        width: responsiveWidth(context, 155.0),
        height: responsiveHeight(context, 209.0),
        padding: EdgeInsets.symmetric(
          horizontal: responsiveWidth(context, 12.0),
          vertical: responsiveHeight(context, 8.0),
        ),
        decoration: BoxDecoration(
          color: COLORs.white,
          border: Border.all(color: const Color(0xFFDBF4D1)),
          borderRadius: BorderRadius.circular(responsiveWidth(context, 10.0)),
        ),
        child: ClipRect(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: const Color(0xFFFF9F06),
                    size: responsiveWidth(context, 16.0),
                  ),
                  SizedBox(width: responsiveWidth(context, 4.0)),
                  Text(
                    item.rating.toString(),
                    style: TextStyle(
                      fontFamily: 'Avenir',
                      fontWeight: FontWeight.w400,
                      fontSize: responsiveWidth(context, 12.0),
                      color: const Color(0xFF0D0D0D),
                      letterSpacing: -0.03 * responsiveWidth(context, 12.0),
                    ),
                  ),
                ],
              ),
              SizedBox(height: responsiveHeight(context, 8.0)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: responsiveWidth(context, 87.0),
                      height: responsiveHeight(context, 70.0),
                      child: Image.asset(
                        item.imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: responsiveHeight(context, 8.0)),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            style: TextStyle(
                              fontFamily: 'Avenir',
                              fontWeight: FontWeight.w500,
                              fontSize: responsiveWidth(context, 18.0),
                              color: const Color(0xFF0D0D0D),
                              letterSpacing: -0.03 * responsiveWidth(context, 18.0),
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          SizedBox(height: responsiveHeight(context, 4.0)),
                          Flexible(
                            child: Text(
                              item.description,
                              style: TextStyle(
                                fontFamily: 'Avenir',
                                fontWeight: FontWeight.w400,
                                fontSize: responsiveWidth(context, 12.0),
                                color: const Color(0xFF3B3B3B),
                                letterSpacing: -0.03 * responsiveWidth(context, 12.0),
                                height: 1.33,
                              ).copyWith(color: const Color(0xFF3B3B3B).withOpacity(0.5)),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          SizedBox(height: responsiveHeight(context, 4.0)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                item.price,
                                style: TextStyle(
                                  fontFamily: 'DM Sans',
                                  fontWeight: FontWeight.w700,
                                  fontSize: responsiveWidth(context, 14.0),
                                  color: const Color(0xFF3E6898),
                                  letterSpacing: -0.03 * responsiveWidth(context, 14.0),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  final cartItem = CartItem(
                                    name: item.title,
                                    restaurant: 'Burger Factory LTD',
                                    price: double.parse(item.price.replaceAll('\$', '')),
                                    imagePath: item.imagePath,
                                    quantity: 1,
                                  );
                                  context.read<CartBloc>().add(AddToCartEvent(cartItem));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Item added to cart!')),
                                  );
                                },
                                child: Container(
                                  width: responsiveWidth(context, 24.0),
                                  height: responsiveHeight(context, 24.0),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF3E6898),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: responsiveWidth(context, 12.0),
                                  ),
                                ),
                              ),
                            ],
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
      ),
    );
  }
}