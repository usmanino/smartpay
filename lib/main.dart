import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:smartplay/app.dart';
import 'package:smartplay/controller/controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider.initialize()),
        ChangeNotifierProvider(create: (_) => OnboardingProvider()),
      ],
      child: const App(),
    ),
  );
}
