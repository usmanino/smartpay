import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartplay/core/styles.dart';

class CustomAppBar extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final bool hasBack;
  final bool hasAuth;
  final bool hasCart;
  final bool hasLike;
  final bool hastitle;
  final bool hassubtitle;
  final bool hasprofile;
  final double fontsize;
  final bool hasSubSpace;
  final bool elevation;
  final Color subColor;
  final FontWeight fontWeight;
  final double width;
  final bool hasSearch;
  CustomAppBar({
    Key? key,
    this.title = '',
    this.width = 130,
    this.subtitle = '',
    this.hasBack = false,
    this.hasAuth = false,
    this.hasCart = false,
    this.fontWeight = FontWeight.w500,
    this.subColor = kWhiteColor,
    this.elevation = false,
    this.hasLike = false,
    this.hastitle = true,
    this.hassubtitle = true,
    this.hasprofile = false,
    this.hasSearch = false,
    this.fontsize = 15,
    this.hasSubSpace = true,
  }) : super(key: key);

  bool notify = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: Row(
            children: [
              if (hasBack)
                InkResponse(
                  radius: 30,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: kPrimaryColor, width: 0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(7.0),
                      child: Icon(
                        Icons.navigate_before,
                        color: kPrimaryColor,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              if (hasprofile)
                Row(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        // image: const DecorationImage(
                        //   image: AssetImage("assets/images/user_avatar.png"),
                        //   //fit: BoxFit.,
                        // ),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.blue,
                          width: 1.0,
                        ),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.only(top: 1),
                          child: SvgPicture.asset('assets/svgs/profile.svg')),
                    ),
                    SizedBox(
                      width: SizeConfig.minBlockHorizontal! * 4.0,
                    ),
                  ],
                ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (hastitle)
                    Text(
                      title!,
                      style: GoogleFonts.poppins(
                        fontSize: fontsize,
                        color: kBlackColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                ],
              ),
              if (hasSubSpace)
                SizedBox(
                  width: width,
                ),
              if (hassubtitle)
                Text(
                  subtitle!,
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: subColor,
                    fontWeight: fontWeight,
                  ),
                ),
              const Spacer(),
              if (hasLike)
                InkResponse(
                  onTap: () {},
                  child: const Icon(
                    Icons.favorite,
                    color: kPrimaryColor,
                    size: 25,
                  ),
                ),
              SizedBox(width: SizeConfig.minBlockHorizontal! * 3),
              if (hasCart)
                InkWell(
                  onTap: () {},
                  child: const Icon(
                    Icons.shopping_cart_outlined,
                    color: kDangerColor,
                    size: 25,
                  ),
                ),
              if (hasSearch)
                InkWell(
                  onTap: () {},
                  child: const Icon(
                    Icons.search,
                    size: 25,
                  ),
                ),
            ],
          ),
        ),
        if (elevation)
          const Divider(
            thickness: 2,
          ),
      ],
    );
  }
}
