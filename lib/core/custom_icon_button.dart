import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smartplay/core/styles.dart';

class CustomIconButton extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? iconColor;
  final bool isCustomIcon;
  final String? customIcon;
  const CustomIconButton({
    Key? key,
    this.text,
    this.icon,
    this.onPressed,
    this.backgroundColor = kBackgroundColor2,
    this.textColor = kBlackColor,
    this.iconColor = kBlackColor,
    this.isCustomIcon = false,
    this.customIcon,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          5.0,
        ),
      ),
      color: backgroundColor,
      padding: const EdgeInsets.only(
        top: 10.0,
        bottom: 10.0,
        right: 10.0,
        left: 5.0,
      ),
      child: Row(
        children: [
          isCustomIcon
              ? SvgPicture.asset(
                  customIcon!,
                  color: iconColor,
                  height: 20.0,
                  width: 20.0,
                )
              : Icon(
                  icon,
                  color: iconColor,
                ),
          SizedBox(
            width: SizeConfig.minBlockHorizontal! * 2.0,
          ),
          Text(
            text!,
            style: kSmallTextStyle.copyWith(
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
