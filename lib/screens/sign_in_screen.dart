import 'package:auth_reg/utils/auth.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<bool> _signIn() async {
    if (!_formKey.currentState!.validate()) {
      return false;
    }
    return await AuthManager.signIn(
        _emailController.text, _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
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
                    child: TextFormField(
                      // Password Form
                      obscureText: true,
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                      ),
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
                        if (await _signIn()) {
                          navigator.pushNamedAndRemoveUntil(
                              '/home', (route) => false);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Invalid Email or Password'),
                            ),
                          );
                        }
                      },
                      child: const Text('Log In')),
                  const SizedBox(
                    height: 30,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: const Text('Sign Up'))
                ],
              )),
        ),
      ),
    );
  }
}
