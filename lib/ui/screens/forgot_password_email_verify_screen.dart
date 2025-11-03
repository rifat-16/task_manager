import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manger/ui/screens/forgot_password_pin_verify_screen.dart';
import '../provider/email_verify_provider.dart';
import '../provider/pin_verify_provider.dart';
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


  // ---------------------- Build UI ----------------------
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EmailVerifyProvider>(
      create: (_) => EmailVerifyProvider(),
      child: Scaffold(
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
                    Consumer<EmailVerifyProvider>(
                      builder: (context, provider, _) {
                        return FilledButton(
                          onPressed: () async {
                            bool success = await provider.emailVerify(_emailTEController.text.trim());
                            if (success) {
                              showSnackBarMessage(context, 'Email Verify Successfully', false);
                              _onTabFilledButton();
                            } else {
                              showSnackBarMessage(context, provider.errorMessage ?? 'Error', true);
                            }
                          },
                          child: provider.isLoading
                              ? SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                              : Icon(Icons.arrow_circle_right_outlined),
                        );
                      },
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
        MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => PinVerifyProvider(),
            child: PinVerifyScreen(email: _emailTEController.text.trim()),
          ),
        ),
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