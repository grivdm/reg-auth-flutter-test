import 'package:auth_reg/screens/home_screen.dart';
import 'package:auth_reg/screens/sign_up_screen.dart';
import 'package:auth_reg/screens/splash_screen.dart';
import 'package:auth_reg/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import './screens/sign_in_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPrefsManager().init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/splash',
      routes: {
        '/signin': (context) => const SignInScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/home': (context) => const HomeScreen(),
        '/splash': (context) => const SplashScreen(),
      },
    );
  }
}
