import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:smartplay/core/styles.dart';
import 'package:smartplay/router/app_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  final animationsMap = {
    'imageOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      duration: 2000,
      fadeIn: true,
      initialState: AnimationState(
        scale: 0.6,
        opacity: 0,
      ),
      finalState: AnimationState(
        scale: 1,
        opacity: 1,
      ),
    ),
  };

  void initState() {
    startPageLoadAnimations(
      animationsMap.values
          .where((anim) => anim.trigger == AnimationTrigger.onPageLoad),
      this,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 4), () {
        Navigator.of(context).pushReplacementNamed(SmartScreen.welcome);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return AnnotatedRegion(
      value: SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.leanBack,
        overlays: [],
      ),
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SvgPicture.asset('assets/svgs/logo.svg')
                  .animated([animationsMap['imageOnPageLoadAnimation']!]),
            ),
            SizedBox(
              height: SizeConfig.minBlockVertical,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Smart",
                  style: TextStyle(
                    fontFamily: 'sf',
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w700,
                    color: kPrimaryColor,
                  ),
                ),
                Text(
                  "pay",
                  style: TextStyle(
                    fontFamily: 'sf',
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w700,
                    color: kSecondaryColor,
                  ),
                ),
              ],
            ).animated([animationsMap['imageOnPageLoadAnimation']!]),
          ],
        ),
      ),
    );
  }
}
