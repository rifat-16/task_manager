import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../widgets/screen_background.dart';
import 'login_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _newPassTEController = TextEditingController();
  final _confirmPassTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundScreen(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 100),
                  Text(
                    'Set New Password',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Make sure your password is strong',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _newPassTEController,
                    obscureText: true,
                    decoration: InputDecoration(hintText: 'New Password'),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _confirmPassTEController,
                    obscureText: true,
                    decoration: InputDecoration(hintText: 'Confirm Password'),
                  ),
                  SizedBox(height: 20),
                  FilledButton(
                    onPressed: _onTabFilledButton,
                    child: Icon(Icons.arrow_circle_right_outlined),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Column(
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'have an account? ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                text: 'Login',
                                style: TextStyle(color: Colors.green),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = _opTabLoginTextButton,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

  }

  void _opTabLoginTextButton() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (__) => LoginScreen()),
      (route) => false,
    );
  }

  void _onTabFilledButton() {}


  @override
  void dispose() {
    _newPassTEController.dispose();
    _confirmPassTEController.dispose();
    super.dispose();
  }
}
