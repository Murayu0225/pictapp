import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pictapp/pages/home.dart';
import 'package:pictapp/pages/home2.dart';
import 'package:pictapp/pages/license.dart';
import 'package:pictapp/pages/signin.dart';
import 'package:pictapp/pages/signup.dart';
import 'package:pictapp/pages/welcome.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const PICTApp());
}

class PICTApp extends StatelessWidget {
  const PICTApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PICT App',
      debugShowCheckedModeBanner: false,
      supportedLocales: const [Locale('ja', 'JP')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate
      ],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: 'welcome',
      routes: {
        'welcome': (context) => const WelcomePage(),
        'signin': (context) => const SignInPage(),
        'signup': (context) => const SignUpPage(),
        'license': (context) => const LicensesPage(),
        'home': (context) => const HomePage(),
        'home2': (context) => const HomePage2(),
      },
    );
  }
}
