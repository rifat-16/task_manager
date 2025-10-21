import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manger/ui/screens/forgot_password_pin_verify_screen.dart';

import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/screen_background.dart';
import '../widgets/snack_bar_message.dart';

class ForgotPasswordEmailVerify extends StatefulWidget {
  const ForgotPasswordEmailVerify({super.key});

  @override
  State<ForgotPasswordEmailVerify> createState() => _ForgotPasswordEmailVerifyState();
}

class _ForgotPasswordEmailVerifyState extends State<ForgotPasswordEmailVerify> {
  final _formKey = GlobalKey<FormState>();
  final _emailTEController = TextEditingController();
  bool _loginInProgress = false;

  // ---------------------- Email Verify Function ----------------------
  Future<void> _emailVerify() async {
    setState(() {
      _loginInProgress = true;
    });
    final ApiResponse response = await ApiCaller.getRequest(
      url: Urls.forgotPasswordUrl(_emailTEController.text),
    );
    if (response.isSuccess && response.responseData['status'] == 'success') {
      showSnackBarMessage(context, 'Email Sent Successfully', false);
      _onTabFilledButton();
    } else {
      showSnackBarMessage(
        context,
        response.errorMessage!,
        true,
      );
    }
    setState(() {
      _loginInProgress = false;
    });
  }

  // ---------------------- Build UI ----------------------
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
                    'Enter Your Email Address',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'A 6-digit code has been sent to your email',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _emailTEController,
                    decoration: InputDecoration(hintText: 'Email'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  FilledButton(
                    onPressed: _emailVerify,
                    child: Visibility(
                      visible: !_loginInProgress,
                      replacement: Center(child: CircularProgressIndicator()),
                      child: Icon(Icons.arrow_circle_right_outlined),
                    ),
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
                                recognizer: TapGestureRecognizer()..onTap = _opTabLoginTextButton,
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

  // ---------------------- Navigation & Button Functions ----------------------
  void _opTabLoginTextButton() {
    Navigator.pop(context);
  }

  void _onTabFilledButton() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (__) => PinVerifyScreen(email: _emailTEController.text,)),
      );
    }
  }

  // ---------------------- Dispose ----------------------
  @override
  void dispose() {
    _emailTEController.dispose();
    super.dispose();
  }
}