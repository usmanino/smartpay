import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:smartplay/core/styles.dart';
import 'package:smartplay/router/app_router.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) {
        final FocusScopeNode currentScope = FocusScope.of(context);
        if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: Sizer(builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'Eazy Commute',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light().copyWith(
            textTheme: ThemeData.light().textTheme.apply(),
            switchTheme: SwitchThemeData(
              trackColor: MaterialStateProperty.all(kSecondaryColor),
              thumbColor: MaterialStateProperty.all(kPrimaryColor),
            ),
            checkboxTheme: CheckboxThemeData(
              fillColor: MaterialStateProperty.all(kPrimaryColor),
            ),
            appBarTheme: const AppBarTheme(
              color: kScaffoldColor,
            ),
          ),
          onGenerateRoute: AppRouter.route,
          initialRoute: SmartScreen.splash,
        );
      }),
    );
  }
}
