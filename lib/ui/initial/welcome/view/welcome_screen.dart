import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartplay/controller/user_provider.dart';
import 'package:smartplay/core/size_config.dart';
import 'package:smartplay/ui/home/view/enter_pin_screen.dart';
import 'package:smartplay/ui/home/view/home.dart';
import 'package:smartplay/ui/initial/onboarding/widget/onboarding_tiles.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool user = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    if (userProvider.status == UserStatus.authenticated) {
      return const EnterPinScreen();
    } else if (userProvider.status == UserStatus.unauthorized) {
      return OnBoardingTiles();
    } else {
      return const Scaffold(
        body: Text('loading'),
      );
    }
  }
}
