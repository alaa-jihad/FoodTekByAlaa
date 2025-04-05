import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../feature/cart/domain/entity/cart_entity.dart';
import '../../../feature/cart/presentation/cubit/cart_cubit.dart';
import '../../../feature/cart/presentation/state/cart_event.dart';
import '../../../feature/details_screen/presentation/view/details_screen.dart';
import '../../../feature/home/domain/entity/select_category_item.dart';
import '../../constants/color.dart';
import '../../constants/svg.dart';
import '../../utils/responsive.dart';

class SelectCategory extends StatelessWidget {
  final String selectedCategory;
  final List<SelectCategoryItem> items;
  final List<SelectCategoryItem> favoritedItems;
  final void Function(SelectCategoryItem) onFavoriteToggle;

  const SelectCategory({
    super.key,
    required this.selectedCategory,
    required this.items,
    required this.favoritedItems,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    final filteredItems = selectedCategory == 'All'
        ? items
        : items.where((item) => item.category == selectedCategory).toList();
    print('SelectCategory filteredItems: ${filteredItems.map((e) => e.title).toList()}');
    return GridView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: responsiveWidth(context, 13.0),
        mainAxisSpacing: responsiveHeight(context, 11.0),
        childAspectRatio: 177 / 252,
      ),
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        final item = filteredItems[index];
        return _buildCategoryCard(context, item);
      },
    );
  }

  Widget _buildCategoryCard(BuildContext context, SelectCategoryItem item) {
    final isFavorited = favoritedItems.contains(item);

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
            ),
          ),
        );
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: responsiveWidth(context, 174.0),
            height: responsiveHeight(context, 200.0),
            margin: EdgeInsets.only(top: responsiveHeight(context, 52.0)),
            decoration: BoxDecoration(
              border: Border.all(color: COLORs.bluebottom),
              borderRadius: BorderRadius.circular(responsiveWidth(context, 25.0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: responsiveHeight(context, 58.0)),
                Text(
                  item.title,
                  style: TextStyle(
                    fontFamily: 'Sora',
                    fontWeight: FontWeight.w600,
                    fontSize: responsiveWidth(context, 14.0),
                    color: const Color(0xFF24262F),
                    height: 15 / 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: responsiveHeight(context, 30.0)),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: responsiveWidth(context, 19.5)),
                    child: Text(
                      item.description,
                      style: TextStyle(
                        fontFamily: 'Sora',
                        fontWeight: FontWeight.w300,
                        fontSize: responsiveWidth(context, 10.0),
                        color: const Color(0xFF969AB0),
                        height: 12 / 10,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                SizedBox(height: responsiveHeight(context, 8.0)),
                Text(
                  item.price,
                  style: TextStyle(
                    fontFamily: 'Sora',
                    fontWeight: FontWeight.w600,
                    fontSize: responsiveWidth(context, 14.0),
                    color: const Color(0xFF24262F),
                    height: 15 / 14,
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
          Positioned(
            bottom: responsiveHeight(context, 7.0),
            left: responsiveWidth(context, 42),
            child: GestureDetector(
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
                width: responsiveWidth(context, 95.0),
                height: responsiveHeight(context, 27.0),
                decoration: BoxDecoration(
                  color: COLORs.blue1,
                  borderRadius: BorderRadius.circular(responsiveWidth(context, 25.0)),
                ),
                child: Center(
                  child: Text(
                    'Order Now',
                    style: TextStyle(
                      fontFamily: 'Sora',
                      fontWeight: FontWeight.w400,
                      fontSize: responsiveWidth(context, 10.0),
                      color: Colors.white,
                      height: 15 / 10,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: responsiveHeight(context, 7.0),
            left: responsiveWidth(context, (174.0 - 89.0) / 2),
            child: Container(
              width: responsiveWidth(context, 89.0),
              height: responsiveHeight(context, 89.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFEEEEEE),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromRGBO(118, 118, 118, 0.25),
                    offset: const Offset(0, -5),
                    blurRadius: 25,
                  ),
                  BoxShadow(
                    color: const Color.fromRGBO(129, 129, 129, 0.25),
                    offset: const Offset(0, 3),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  item.imagePath,
                  width: responsiveWidth(context, 74.0),
                  height: responsiveHeight(context, 74.0),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: responsiveHeight(context, 35.0),
            right: 15,
            child: GestureDetector(
              onTap: () => onFavoriteToggle(item),
              child: Container(
                width: responsiveWidth(context, 35.0),
                height: responsiveHeight(context, 35.0),
                decoration: BoxDecoration(
                  color: COLORs.bluebottom,
                  border: Border.all(color: COLORs.bluebottom, width: 2.0),
                  borderRadius: BorderRadius.circular(responsiveWidth(context, 14.0)),
                ),
                child: Center(
                  child: Icon(
                    isFavorited ? Icons.favorite : Icons.favorite_outline_outlined,
                    color: isFavorited ? Colors.red : const Color(0xFF222628),
                    size: 18.0,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: responsiveWidth(context, 13.0),
            top: responsiveHeight(context, 158.0),
            child: SvgPicture.asset(
              SVGs.power,
              height: responsiveHeight(context, 9),
              width: responsiveWidth(context, 8),
            ),
          ),
        ],
      ),
    );
  }
}