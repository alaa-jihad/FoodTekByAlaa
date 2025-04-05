import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../../constants/color.dart';
import '../../constants/svg.dart';
import '../../utils/responsive.dart';
import '../../constants/png.dart'; // Assuming PNGs.jordan and PNGs.palestine are defined here

enum TextFieldType {
  text,
  date,
  phone,
}

class CustomTextField extends StatefulWidget {
  final String hintText;
  final String? svgIcon;
  final bool isPassword;
  final TextEditingController controller;
  final String title;
  final double height;
  final double width;
  final String? Function(String?)? validator;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final void Function(String)? onChanged;
  final TextFieldType fieldType;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.height,
    required this.width,
    this.svgIcon,
    this.isPassword = false,
    required this.controller,
    required this.title,
    this.validator,
    this.borderColor = COLORs.whitef4,
    this.focusedBorderColor = COLORs.blue1,
    this.errorBorderColor = COLORs.blue1,
    this.onChanged,
    this.fieldType = TextFieldType.text,
  });

  @override
  State<CustomTextField> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextField> {
  bool _isObscured = true;
  String _selectedCountryCode = '+962'; // Default to Jordan

  // List of country codes with their flags
  final List<Map<String, String>> _countryCodes = [
    {'code': '+962', 'flag': PNGs.jordan, 'hint': '+962771234567'},
    {'code': '+970', 'flag': PNGs.palestine, 'hint': '+970591234567'},
  ];

  // Dynamic hint text based on selected country code
  String getDynamicHintText() {
    return _countryCodes
        .firstWhere((country) => country['code'] == _selectedCountryCode)['hint']!;
  }

  // Function to show the date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        widget.controller.text = DateFormat('dd/MM/yyyy').format(picked);
      });
      if (widget.onChanged != null) {
        widget.onChanged!(widget.controller.text);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: responsiveWidth(context, 295),
      height: responsiveHeight(context, 69),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontWeight: FontWeight.w700,
              fontSize: 12,
              height: 1.6,
              letterSpacing: -0.02,
              color: COLORs.darkgray,
            ),
          ),
          SizedBox(height: responsiveHeight(context, 2)),
          Expanded(
            child: TextFormField(
              controller: widget.controller,
              obscureText: widget.isPassword ? _isObscured : false,
              validator: widget.validator,
              onChanged: widget.onChanged,
              readOnly: widget.fieldType == TextFieldType.date,
              keyboardType: widget.fieldType == TextFieldType.phone
                  ? TextInputType.phone
                  : TextInputType.text,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                fontSize: 14,
                height: 1.4,
                letterSpacing: -0.01,
                color: COLORs.black22,
              ),
              decoration: InputDecoration(
                prefixIcon: widget.fieldType == TextFieldType.phone
                    ? Padding(
                  padding: EdgeInsets.only(
                    left: responsiveWidth(context, 14),
                    right: responsiveWidth(context, 12),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedCountryCode,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedCountryCode = newValue!;
                          if (widget.onChanged != null) {
                            widget.onChanged!(widget.controller.text);
                          }
                        });
                      },
                      items: _countryCodes.map((Map<String, String> country) {
                        return DropdownMenuItem<String>(
                          value: country['code'],
                          child: Image.asset(
                            country['flag']!,
                            height: 18.sp,
                            width: 18.sp,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                )
                    : widget.svgIcon != null
                    ? Padding(
                  padding: EdgeInsets.only(
                    left: responsiveWidth(context, 14),
                    right: responsiveWidth(context, 12),
                  ),
                  child: SizedBox(
                    width: responsiveWidth(context, 16),
                    height: responsiveHeight(context, 16),
                    child: SvgPicture.asset(
                      widget.svgIcon!,
                      fit: BoxFit.scaleDown,
                      color: COLORs.black41,
                    ),
                  ),
                )
                    : null,
                hintText: widget.fieldType == TextFieldType.phone
                    ? getDynamicHintText()
                    : widget.hintText,
                hintStyle: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  height: 1.4,
                  letterSpacing: -0.01,
                  color: COLORs.black22,
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: responsiveHeight(context, 12.5),
                  horizontal: responsiveWidth(context, 14),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: COLORs.borderColor,
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: COLORs.borderColor,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: widget.focusedBorderColor ?? COLORs.blue1,
                    width: 2.0,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: widget.errorBorderColor ?? COLORs.blue1,
                    width: 1.5,
                  ),
                ),
                suffixIcon: widget.isPassword
                    ? IconButton(
                  icon: _isObscured
                      ? SvgPicture.asset(
                    SVGs.invisibilityIcon,
                    width: responsiveWidth(context, 16),
                    height: responsiveHeight(context, 16),
                    fit: BoxFit.scaleDown,
                  )
                      : SvgPicture.asset(
                    SVGs.visibility,
                    width: responsiveWidth(context, 16),
                    height: responsiveHeight(context, 16),
                    fit: BoxFit.scaleDown,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscured = !_isObscured;
                    });
                  },
                )
                    : widget.fieldType == TextFieldType.date
                    ? IconButton(
                  icon: SvgPicture.asset(
                    SVGs.calendarIcon,
                    width: responsiveWidth(context, 16),
                    height: responsiveHeight(context, 16),
                    fit: BoxFit.scaleDown,
                  ),
                  onPressed: () => _selectDate(context),
                )
                    : null,
              ),
              onTap: widget.fieldType == TextFieldType.date
                  ? () => _selectDate(context)
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}