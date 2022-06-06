import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartplay/controller/controller.dart';
import 'package:smartplay/controller/onboarding_provider.dart';
import 'package:smartplay/core/styles.dart';
import 'package:smartplay/router/app_router.dart';
import 'package:smartplay/ui/initial/onboarding/view/onboarding_screen.dart';

class OnBoardingTiles extends StatelessWidget {
  OnBoardingTiles({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final onboardProvider = Provider.of<OnboardingProvider>(context);
    SizeConfig().init(context);

    return OnboardScreen(
      button: SolidButton(
        text: "Get Started",
        radius: 16,
        onPressed: () {
          Navigator.of(context).pushNamed(
            SmartScreen.login,
          );
        },
        color: kPrimaryColor,
      ),

      /// This function works when you will complete `OnBoarding`
      //function: () {},

      /// This [mySlides] must not be more than 5.
      mySlides: onboardProvider.mySlides,
      controller: onboardProvider.pageController,
      slideIndex: 0,
      statusBarColor: Colors.white,

      skipStyle: const TextStyle(color: kPrimaryColor),
      pageIndicatorColorList: const [
        kPrimaryColor,
        kPrimaryColor,
        kPrimaryColor
      ],
    );
  }
}
