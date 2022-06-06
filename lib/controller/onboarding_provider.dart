import 'package:flutter/material.dart';
import 'package:smartplay/model/slide_models.dart';

class OnboardingProvider extends ChangeNotifier {
  int _selectedPageIndex = 0;

  //  bool get isLastPage => selectedPageIndex == mySlides.length - 1;
  var pageController = PageController();

  int get selectedPageIndex => _selectedPageIndex;

  set selectedPageIndex(int index) {
    _selectedPageIndex = index;
    notifyListeners();
  }

  List<SliderModel> mySlides = [
    SliderModel(
        'assets/images/device.png',
        'assets/images/p1.png',
        'Finance app the safest and most trusted',
        'Your finance work starts here. Our here to help you track and deal with speeding up your transactions.'),
    SliderModel(
        'assets/images/device_2.png',
        'assets/images/p2.png',
        'The fastest transaction process only here',
        'Get easy to pay all your bills with just a few steps. Paying your bills become fast and efficient.'),
  ];

  // List<SliderModel> mySlides2 = [
  //   SliderModel(
  //       'assets/images/p1.png',
  //       'Finance app the safest and most trusted',
  //       'Your finance work starts here. Our here to help you track and deal with speeding up your transactions.'),
  //   SliderModel(
  //       'assets/images/p2.png',
  //       'The fastest transaction process only here',
  //       'Get easy to pay all your bills with just a few steps. Paying your bills become fast and efficient.'),
  // ];
}
