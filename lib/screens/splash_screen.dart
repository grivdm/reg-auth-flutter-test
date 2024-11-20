import 'package:auth_reg/utils/shared_preferences.dart';
import 'package:auth_reg/utils/token.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateBasedOnToken();
  }

  void _navigateBasedOnToken() {
    final String sessionToken = SharedPrefsManager().getSessionToken;
    final isTokenValid = TokenManager.isTokenValid(sessionToken);

    final nextRoute = isTokenValid ? '/home' : '/signin';
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacementNamed(context, nextRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
