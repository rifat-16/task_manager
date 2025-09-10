
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../widgets/screen_background.dart';
import 'login_screen.dart';

class SingupScreen extends StatefulWidget {
  const SingupScreen({super.key});

  @override
  State<SingupScreen> createState() => _SingupScreenState();
}

class _SingupScreenState extends State<SingupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailTEController = TextEditingController();
  final _passwordTEController = TextEditingController();
  final _fastNameTEController = TextEditingController();
  final _lastNameTEController = TextEditingController();
  final _phoneNumberTEController = TextEditingController();

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
                    'Create Your Account',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                      controller: _emailTEController,
                      decoration: InputDecoration(hintText: 'Email')
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _fastNameTEController,
                    decoration: InputDecoration(hintText: 'Fast Name'),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _lastNameTEController,
                    decoration: InputDecoration(hintText: 'Last Name'),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _phoneNumberTEController,
                    decoration: InputDecoration(hintText: 'Phone Number'),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                      controller: _passwordTEController,
                      obscureText: true,
                      decoration: InputDecoration(hintText: 'Password')
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
                            style: TextStyle(color: Colors.black, fontSize: 15,
                              fontWeight: FontWeight.bold,),
                            children: [
                              TextSpan(
                                text: 'Login',
                                style: TextStyle(color: Colors.green),
                                recognizer: TapGestureRecognizer()..onTap = _opTabLoginTextButton,
                              )
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
  void _onTabFilledButton(){}

  void _opTabLoginTextButton() {
    Navigator.pop(context);
  }



}
