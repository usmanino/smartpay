import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smartplay/controller/controller.dart';
import 'package:smartplay/core/size_config.dart';
import 'package:smartplay/core/styles.dart';
import 'package:smartplay/ui/initial/onboarding/widget/page_indicator.dart';

class OnboardScreen extends StatefulWidget {
  OnboardScreen({
    Key? key,
    this.button,
    this.label = const Text('Button'),
    this.mySlides = const [],
    required this.controller,
    this.slideIndex = 0,
    this.skipStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
    this.function,
    this.startGradientColor = const Color(0xffffffff),
    this.endGradientColor = const Color(0xffffffff),
    this.statusBarColor = const Color(0xffffffff),
    this.scaffoldColor = const Color(0xffffffff),
    this.statusBarIconBrightness = Brightness.dark,
    this.pageIndicatorColorList = const [],
  })  : assert(mySlides.length < 6, 'Slides\'s size must not be more than 5'),
        super(key: key);

  /// list of sliders
  final List mySlides;

  /// color of each sliders
  final List<Color?>? pageIndicatorColorList;

  /// current slider index
  int? slideIndex;

  /// label at the last slider
  final Text? label;
  final Widget? button;

  /// controller of slider
  final PageController controller;

  /// defines what to do after pressing [label]
  final Function()? function;

  /// color of scaffold
  final Color? scaffoldColor;

  /// color of status bar
  final Color? statusBarColor;

  final Color? startGradientColor;
  final Color? endGradientColor;

  /// style of skip text
  final TextStyle? skipStyle;

  /// Brightness of status bar icon
  final Brightness? statusBarIconBrightness;

  @override
  // ignore: library_private_types_in_public_api
  _OnboardScreenState createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  @override
  Widget build(BuildContext context) {
    // final onboardProvider = Provider.of<OnboardingProvider>(context);
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: kBackgroundColor2,
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Column(
          children: [
            SizedBox(height: SizeConfig.minBlockVertical!),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // const Padding(padding: EdgeInsets.all(19)),
                TextButton(
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      fontFamily: 'sf',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: kSecondaryColor,
                    ),
                  ),
                  onPressed: () {
                    if (widget.controller.hasClients) {
                      widget.controller.animateToPage(
                        widget.mySlides.length - 1,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.linear,
                      );
                    }
                  },
                ),
              ],
            ),
            Expanded(
              flex: 8,
              child: PageView.builder(
                itemCount: widget.mySlides.length,
                controller: widget.controller,
                onPageChanged: (index) {
                  setState(() {
                    widget.slideIndex = index;
                  });
                },
                itemBuilder: (_, index) => Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      widget.mySlides[index].imageAsset,
                      width: 250,
                    ),
                    Positioned(
                      top: 300,
                      child: Container(
                        color: kBackgroundColor2,
                        height: 300,
                        width: 300,
                        child: Column(
                          children: [
                            SizedBox(
                              height: SizeConfig.minBlockVertical! * 5.0,
                            ),
                            Text(
                              widget.mySlides[index].title,
                              style: GoogleFonts.lato(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: SizeConfig.minBlockVertical! * 2.0,
                            ),
                            Text(
                              widget.mySlides[index].description,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lato(fontSize: 14),
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      for (int i = 0;
                                          i < widget.mySlides.length;
                                          i++)
                                        i == widget.slideIndex
                                            ? buildPageIndicator(
                                                true,
                                                widget.pageIndicatorColorList![
                                                    widget.pageIndicatorColorList!
                                                            .length -
                                                        i -
                                                        1],
                                              )
                                            : buildPageIndicator(
                                                false,
                                                widget.pageIndicatorColorList![
                                                    widget.pageIndicatorColorList!
                                                            .length -
                                                        i -
                                                        1]!,
                                              ),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: widget.function,
                                    child: widget.slideIndex ==
                                            widget.mySlides.length - 1
                                        ? Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: widget.button)
                                        : Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: SolidButton(
                                              text: "Get Started",
                                              radius: 16,
                                              onPressed: () {
                                                widget.controller.nextPage(
                                                  duration: const Duration(
                                                    milliseconds: 400,
                                                  ),
                                                  curve: Curves.linear,
                                                );
                                              },
                                              color: kPrimaryColor,
                                            ),
                                          ),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 90,
                      right: 15,
                      child: Image.asset(
                        widget.mySlides[index].decimage,
                        width: 300,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }
}
