import 'package:flutter/material.dart';

class FilterCategory extends StatefulWidget {
  final Function(String) onCategorySelected; // Callback to notify parent

  const FilterCategory({super.key, required this.onCategorySelected});

  @override
  _FilterCategoryState createState() => _FilterCategoryState();
}

class _FilterCategoryState extends State<FilterCategory> {
  String _selectedFilter = 'All';
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, dynamic>> _categories = [
    {'text': 'All', 'filter': 'All', 'emoji': null},
    {'text': 'Burger', 'filter': 'Burger', 'emoji': '🍔'},
    {'text': 'Pizza', 'filter': 'Pizza', 'emoji': '🍕'},
    {'text': 'Sandwich', 'filter': 'Sandwich', 'emoji': '🌭'},
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: SizedBox(
        height: 43,
        child: SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _categories.map((category) {
              final isSelected = _selectedFilter == category['filter'];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedFilter = category['filter'];
                  });
                  widget.onCategorySelected(_selectedFilter); // Notify parent
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.fromLTRB(8, 8, 20, 8),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF3E6898) : Colors.white,
                    border: Border.all(
                      color: isSelected ? const Color(0xFFDADEF6) : const Color(0xFFACB3D9),
                      width: 0.7,
                    ),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (category['emoji'] != null) ...[
                        Text(
                          category['emoji'],
                          style: const TextStyle(
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            height: 31 / 24,
                            letterSpacing: -0.03,
                            color: Colors.black,
                            shadows: [
                              Shadow(
                                color: Color.fromRGBO(150, 110, 86, 0.2),
                                offset: Offset(0, 8),
                                blurRadius: 15,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                      ],
                      Text(
                        category['text'],
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          height: 27 / 18,
                          letterSpacing: -0.03,
                          color: isSelected ? Colors.white : const Color(0xFF0D0D0D),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}