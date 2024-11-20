import 'package:auth_reg/utils/auth.dart';
import 'package:auth_reg/utils/shared_preferences.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String get userName => SharedPrefsManager().getUserName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Hello, $userName',
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                AuthManager.signOut();
                Navigator.pushNamedAndRemoveUntil(
                    context, '/signin', (route) => false);
              },
              child: const Text('Log Out'),
            )
          ],
        ),
      ),
    );
  }
}
