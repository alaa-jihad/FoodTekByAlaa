import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodtek_app/core/constants/color.dart';
import 'package:foodtek_app/core/constants/svg.dart';
import 'package:foodtek_app/core/utils/responsive.dart';
import 'package:foodtek_app/feature/cart/domain/entity/cart_entity.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../addCard/presentation/view/add_card_screen.dart';
import '../../../cart/presentation/view/cart_screen.dart';
import '../../../main_screen/main_screen.dart';
import '../../../track/presentation/view/track_screen.dart';

class CheckoutScreen extends StatefulWidget {
  final LatLng? selectedLocation;
  final String locationUrl;
  final List<CartItem> cartItems;
  final VoidCallback onChangeLocation; // Callback for "Change" button
  final VoidCallback onOrderPlaced; // Callback for "Place My Order" button

  const CheckoutScreen({
    super.key,
    required this.selectedLocation,
    required this.locationUrl,
    required this.cartItems,
    required this.onChangeLocation,
    required this.onOrderPlaced,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String _selectedPaymentMethod = 'Card';
  String _selectedCardType = 'MasterCard';
  String _promoCode = '';
  final TextEditingController _promoController = TextEditingController();

  @override
  void dispose() {
    _promoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final subTotal = widget.cartItems.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
    const deliveryCharge = 10.0;
    double discount = 0.0;
    if (_promoCode.isNotEmpty) {
      discount = 10.0;
    }
    final total = subTotal + deliveryCharge - discount;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Checkout Title
            const Text(
              'Checkout',
              style: TextStyle(
                fontFamily: 'Inter',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w700,
                fontSize: 24,
                color: Color(0xFF0A0D13),
              ),
            ),
            const SizedBox(height: 24),

            // Address Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Pay With:',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Color(0xFF0A0D13),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.location_pin,
                              color: Color(0xFF3E6898),
                              size: 16,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              '88 Zurab Gorgiladze St',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                color: Color(0xFF2F2E36),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        const Padding(
                          padding: EdgeInsets.only(left: 24),
                          child: Text(
                            '5 Noe Zhordania St',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                              color: Color(0xFFB8B8B8),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: widget.onChangeLocation, // Use the callback
                      child: const Text(
                        'Change',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Color(0xFF3E6898),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 27),

            // Promo Code Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Promo Code?',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Color(0xFF0A0D13),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: 376,
                  height: 42,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: const Color(0xFFD6D6D6)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextField(
                            controller: _promoController,
                            decoration: const InputDecoration(
                              hintText: 'Enter Your Promo',
                              hintStyle: TextStyle(
                                fontFamily: 'Inter',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Color(0xFF878787),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _promoCode = _promoController.text;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Promo code applied: $_promoCode')),
                            );
                          });
                        },
                        child: Container(
                          width: 90,
                          height: 42,
                          decoration: const BoxDecoration(
                            color: Color(0xFF3E6898),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'Add',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 27),

            // Payment Method Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Pay With:',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Color(0xFF0A0D13),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _buildPaymentOption('Card', _selectedPaymentMethod == 'Card', () {
                      setState(() {
                        _selectedPaymentMethod = 'Card';
                      });
                    }),
                    const SizedBox(width: 19),
                    _buildPaymentOption('Cash', _selectedPaymentMethod == 'Cash', () {
                      setState(() {
                        _selectedPaymentMethod = 'Cash';
                      });
                    }),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 27),

            // Card Type Section
            if (_selectedPaymentMethod == 'Card') ...[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Card Type:',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Color(0xFF0A0D13),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: _buildCardTypeOption('MasterCard', _selectedCardType == 'MasterCard', () {
                          setState(() {
                            _selectedCardType = 'MasterCard';
                          });
                        }),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildCardTypeOption('Visa', _selectedCardType == 'Visa', () {
                          setState(() {
                            _selectedCardType = 'Visa';
                          });
                        }),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 27),
            ],

            // Price Summary
            Container(
              width: 378,
              height: 229,
              decoration: const BoxDecoration(
                color: Color(0xFF3E6898),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(7),
                  topRight: Radius.circular(7),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.07),
                    offset: Offset(12, 26),
                    blurRadius: 50,
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Opacity(
                      opacity: 0.2,
                      child: Image.asset(
                        'assets/images/png/card_background.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: responsiveHeight(context, 45)),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        _buildPriceRow('Sub-Total', '\$${subTotal.toStringAsFixed(0)}'),
                        _buildPriceRow('Delivery Charge', '\$${deliveryCharge.toStringAsFixed(0)}'),
                        if (discount > 0)
                          _buildPriceRow('Discount', '-\$${discount.toStringAsFixed(0)}'),
                        _buildPriceRow('TOTAL:', '\$${total.toStringAsFixed(0)}', isTotal: true),
                        const SizedBox(height: 14),
                        GestureDetector(
                          onTap: () {
                            if (_selectedPaymentMethod == 'Card') {
                              // Navigate to AddCardScreen if payment method is Card
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddCardScreen(
                                    cartItems: widget.cartItems, // Pass the actual cart items
                                    locationUrl: widget.locationUrl, // Pass the location URL
                                    selectedLocation: widget.selectedLocation, // Pass the selected location
                                    onPaymentSuccess: () {
                                      widget.onOrderPlaced(); // Call the callback after payment
                                    },
                                  ),
                                ),
                              );
                            } else {
                              // For Cash payment, directly place the order
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Order placed successfully!')),
                              );
                              widget.onOrderPlaced();
                            }
                          },
                          child: Container(
                            width: 366,
                            height: 57,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(7),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: const Center(
                              child: Text(
                                'Place My Order',
                                style: TextStyle(
                                  color: Color(0xFF3E6898),
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 100), // Extra space for bottom navigation bar
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 15,
            height: 15,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? const Color(0xFF3E6898) : const Color(0xFFACACAC),
                width: 2,
              ),
            ),
            child: isSelected
                ? const Center(
              child: CircleAvatar(
                radius: 4.5,
                backgroundColor: Color(0xFF3E6898),
              ),
            )
                : null,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              fontFamily: 'Inter',
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: isSelected ? const Color(0xFF0A0D13) : const Color(0xFFACACAC),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardTypeOption(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 15,
            height: 15,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? const Color(0xFF3E6898) : const Color(0xFFACACAC),
                width: 2,
              ),
            ),
            child: isSelected
                ? const Center(
              child: CircleAvatar(
                radius: 4.5,
                backgroundColor: Color(0xFF3E6898),
              ),
            )
                : null,
          ),
          const SizedBox(width: 8),
          if (text == 'MasterCard')
            Image.asset(
              'assets/images/png/card.png',
              width: 23,
              height: 22,
            )
          else if (text == 'Visa')
            Image.asset(
              'assets/images/png/visa.png',
              width: 23,
              height: 22,
            ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.w400,
              fontSize: isTotal ? 18 : 14,
              letterSpacing: isTotal ? 0.64 : 0.5,
              color: const Color(0xFFFEFEFF),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.w400,
              fontSize: isTotal ? 18 : 14,
              letterSpacing: isTotal ? 0.64 : 0.5,
              color: const Color(0xFFFEFEFF),
            ),
          ),
        ],
      ),
    );
  }
}