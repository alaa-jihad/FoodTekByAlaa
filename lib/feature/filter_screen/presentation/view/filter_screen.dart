import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  // State variables for the sliders
  RangeValues _priceRange = const RangeValues(0, 198);
  RangeValues _discountRange = const RangeValues(0, 50);

  // State for category selection
  List<bool> _categorySelection = [false, false, false]; // Fast Food, Sea Food, Dessert

  // State for location selection
  int _selectedLocation = 0; // 0: 1 KM, 1: 5 KM, 2: 10 KM

  // State for dish type selection
  List<bool> _dishSelection = [false, false, false, false, false]; // Tuna Tartare, Spicy Crab Cakes, etc.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Filter',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Color(0xFF391713),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Price Range Section
              const Text(
                'Price',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Color(0xFF98A0B4),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 181,
                    height: 38,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFEAFAEB)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        '\$${_priceRange.start.round()}',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Color(0xFF4B4B4B),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 181,
                    height: 38,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFEAFAEB)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        '\$${_priceRange.end.round()}',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Color(0xFF4B4B4B),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              RangeSlider(
                values: _priceRange,
                min: 0,
                max: 198,
                divisions: 198,
                activeColor: const Color(0xFF3E6898),
                inactiveColor: const Color(0xFFF5F5F5),
                onChanged: (RangeValues values) {
                  setState(() {
                    _priceRange = values;
                  });
                },
              ),

              // Discount Range Section
              const SizedBox(height: 24),
              const Text(
                'Discount',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Color(0xFF98A0B4),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 181,
                    height: 38,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFEAFAEB)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        '${_discountRange.start.round()}%',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Color(0xFF4B4B4B),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 181,
                    height: 38,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFEAFAEB)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        '${_discountRange.end.round()}%',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Color(0xFF4B4B4B),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              RangeSlider(
                values: _discountRange,
                min: 0,
                max: 50,
                divisions: 50,
                activeColor: const Color(0xFF3E6898),
                inactiveColor: const Color(0xFFF5F5F5),
                onChanged: (RangeValues values) {
                  setState(() {
                    _discountRange = values;
                  });
                },
              ),

              // Category Section
              const SizedBox(height: 24),
              const Text(
                'Category',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Color(0xFF98A0B4),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCategoryButton('Fast Food', 0),
                  _buildCategoryButton('Sea Food', 1),
                  _buildCategoryButton('Dessert', 2),
                ],
              ),

              // Location Section
              const SizedBox(height: 24),
              const Text(
                'Location',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Color(0xFF98A0B4),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildLocationButton('1 KM', 0),
                  _buildLocationButton('5 KM', 1),
                  _buildLocationButton('10 KM', 2),
                ],
              ),

              // Dish Type Section
              const SizedBox(height: 24),
              const Text(
                'Dish',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Color(0xFF98A0B4),
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  _buildDishButton('Tuna Tartare', 0),
                  _buildDishButton('Spicy Crab Cakes', 1),
                  _buildDishButton('Seafood Paella', 2),
                  _buildDishButton('Clam Chowder', 3),
                  _buildDishButton('Miso-Glazed Cod', 4),
                  _buildDishButton('Lobster Thermidor', 4),
                ],
              ),

              // Apply Button
              const SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Pass the filter values back and close the screen
                    Navigator.pop(context, {
                      'priceRange': _priceRange,
                      'discountRange': _discountRange,
                      'categories': _categorySelection,
                      'location': _selectedLocation,
                      'dishes': _dishSelection,
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3E6898),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 12,
                    ),
                  ),
                  child: const Text(
                    'Apply Filters',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryButton(String title, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _categorySelection[index] = !_categorySelection[index];
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: _categorySelection[index]
              ? const Color(0xFF3E6898)
              : const Color(0xFFF2F4F7),
          borderRadius: BorderRadius.circular(7),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            fontSize: 12,
            color: _categorySelection[index]
                ? Colors.white
                : const Color(0xFF4B4B4B),
          ),
        ),
      ),
    );
  }

  Widget _buildLocationButton(String title, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedLocation = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: _selectedLocation == index
              ? const Color(0xFF3E6898)
              : const Color(0xFFF2F4F7),
          borderRadius: BorderRadius.circular(7),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            fontSize: 12,
            color: _selectedLocation == index
                ? Colors.white
                : const Color(0xFF4B4B4B),
          ),
        ),
      ),
    );
  }

  Widget _buildDishButton(String title, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _dishSelection[index] = !_dishSelection[index];
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: _dishSelection[index]
              ? const Color(0xFF3E6898)
              : const Color(0xFFF2F4F7),
          borderRadius: BorderRadius.circular(7),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            fontSize: 12,
            color: _dishSelection[index]
                ? Colors.white
                : const Color(0xFF4B4B4B),
          ),
        ),
      ),
    );
  }
}