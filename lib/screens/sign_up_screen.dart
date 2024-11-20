import 'package:auth_reg/utils/auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String userName = '';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<bool> _signUp() async {
    if (!_formKey.currentState!.validate()) {
      return false;
    }
    await AuthManager.signUp(
        _emailController.text, _passwordController.text, userName);
    return await AuthManager.signIn(
        _emailController.text, _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 80,
                  child: TextFormField(
                    // Email Form
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      final emailRegExp = RegExp(r'^[\w]+@[\w]+\.[\w]+$');
                      if (!emailRegExp.hasMatch(value!)) {
                        return 'Email is invalid';
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 80,
                  child: TextField(
                    // Name Form
                    decoration: const InputDecoration(labelText: 'User Name'),
                    onChanged: (value) => userName = value,
                  ),
                ),
                SizedBox(
                  height: 80,
                  child: TextFormField(
                    // Password Form
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: (value) {
                      final emailRegExp = RegExp(r'^.{8,}$');
                      if (!emailRegExp.hasMatch(value!)) {
                        return 'Password is invalid (minimum 8 chars)';
                      }
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final navigator = Navigator.of(context);
                    try {
                      final isSignedUp = await _signUp();
                      if (isSignedUp) {
                        navigator.pushNamedAndRemoveUntil(
                          '/home',
                          (route) => false,
                        );
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Sign Up failed: $e')));
                    }
                  },
                  child: const Text('Sign Up'),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signin');
                    },
                    child: const Text('Sign In'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
