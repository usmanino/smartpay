import 'package:flutter/material.dart';
import 'package:smartplay/core/styles.dart';

class SelectBox extends StatelessWidget {
  final List<DropdownMenuItem> items;
  final FormFieldValidator<dynamic>? validator;
  final double radius;
  final dynamic value;
  final ValueChanged? onChanged;
  final BorderSide borderSide;
  final IconData? preicon;
  final bool isPrefix;
  SelectBox({
    required this.items,
    this.validator,
    this.radius = 8.0,
    this.value,
    this.onChanged,
    this.preicon,
    this.isPrefix = false,
    this.borderSide = BorderSide.none,
  });
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: value,
      items: items,
      isExpanded: true,
      validator: validator,
      decoration: InputDecoration(
        hintStyle: const TextStyle(
          color: kBlackColor,
        ),
        filled: true,
        fillColor: const Color(0xFFF7F8F9),
        labelStyle: const TextStyle(
          color: kSecondaryColor,
        ),
        prefixIcon: isPrefix
            ? Icon(
                preicon,
              )
            : null,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            radius,
          ),
          borderSide: borderSide,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            radius,
          ),
          borderSide: borderSide,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            radius,
          ),
          borderSide: borderSide,
        ),
        contentPadding: const EdgeInsets.only(
          left: 10.0,
          bottom: 12.0,
          top: 12.0,
          right: 10.0,
        ),
      ),
      onChanged: onChanged,
      dropdownColor: kWhiteColor,
      style: const TextStyle(
        color: kDarkColor,
      ),
      iconEnabledColor: kBlackColor,
      icon: const Icon(
        Icons.keyboard_arrow_down,
        size: 25.0,
        color: kBlackColor,
      ),
    );
  }
}
