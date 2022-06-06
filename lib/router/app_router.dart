import 'package:flutter/material.dart';
import 'package:smartplay/ui/auth/contry/view/contry.dart';
import 'package:smartplay/ui/auth/forgetpassword/view/forget_password.dart';
import 'package:smartplay/ui/auth/login/view/login.dart';
import 'package:smartplay/ui/auth/reg/view/signup.dart';
import 'package:smartplay/ui/auth/verification/view/verification.dart';
import 'package:smartplay/ui/createpin/view/create_pin_screen.dart';
import 'package:smartplay/ui/initial/splash/view/splash.dart';
import 'package:smartplay/ui/initial/welcome/view/welcome.dart';

class SmartScreen {
  /// The first page when the app loads
  static const String splash = '/';

  static const String welcome = '/welcome';

  static const String login = '/login';

  static const String signup = '/signup';

  static const String verification = '/verification';

  static const String selectcontry = '/selectcontry';

  static const String createpin = '/createpin';

  static const String forgetpassword = '/forgetpassword';
}

///The main app routes logic using router generator
class AppRouter {
  ///list of all the app routes
  static Route route(RouteSettings settings) {
    //  final args = settings.arguments;
    switch (settings.name) {
      case SmartScreen.splash:
        return MaterialPageRoute<Widget>(
          builder: (context) {
            return const SplashScreen();
          },
        );

      case SmartScreen.welcome:
        return MaterialPageRoute<Widget>(
          builder: (context) {
            return const WelcomeScreen();
          },
        );

      case SmartScreen.login:
        return MaterialPageRoute<Widget>(
          builder: (context) {
            return const LoginScreen();
          },
        );

      case SmartScreen.signup:
        return MaterialPageRoute<Widget>(
          builder: (context) {
            return const SignupScreen();
          },
        );

      case SmartScreen.verification:
        return MaterialPageRoute<Widget>(
          builder: (context) {
            return const VerificationScreen();
          },
        );

      case SmartScreen.selectcontry:
        return MaterialPageRoute<Widget>(
          builder: (context) {
            return const ContryScreen();
          },
        );

      case SmartScreen.createpin:
        return MaterialPageRoute<Widget>(
          builder: (context) {
            return const CreatePinScreen();
          },
        );

      case SmartScreen.forgetpassword:
        return MaterialPageRoute<Widget>(
          builder: (context) {
            return const ForgetPasswordScreen();
          },
        );

      default:
        return MaterialPageRoute<Widget>(
          builder: (context) {
            return const Material(
              child: Center(
                child: Text('Unknown Page'),
              ),
            );
          },
        );
    }
  }
}
