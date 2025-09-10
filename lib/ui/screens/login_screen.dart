import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manger/ui/screens/singup_screen.dart';
import '../widgets/screen_background.dart';
import 'forgot_password_email_verify_screen.dart';
import 'main_nav_ber_holder_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailTEController = TextEditingController();
  final _passwordTEController = TextEditingController();

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
                    'Get Started With',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _emailTEController,
                    decoration: InputDecoration(hintText: 'Email'),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: _passwordTEController,
                    obscureText: true,
                    decoration: InputDecoration(hintText: 'Password'),
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
                        TextButton(
                          onPressed: _onTabForgotPasswordButton,
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Don\'t have an account? ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                text: 'Sign Up',
                                style: TextStyle(color: Colors.green),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = _onTabSingUpTextButton,
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
  void _onTabSingUpTextButton() {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (__) => SingupScreen()));
  }

  void _onTabForgotPasswordButton() {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (__) => ForgotPasswordEmailVerify()));
  }

  void _onTabFilledButton() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (__) => MainNavBerHolderScreen()),
      (route) => false,
    );
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }

}

