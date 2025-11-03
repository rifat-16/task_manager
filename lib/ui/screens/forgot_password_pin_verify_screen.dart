import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'login_screen.dart';
import 'reset_password_screen.dart';
import '../provider/pin_verify_provider.dart';
import '../widgets/screen_background.dart';
import '../widgets/snack_bar_message.dart';

class PinVerifyScreen extends StatefulWidget {
  final String email;
  const PinVerifyScreen({super.key, required this.email});

  @override
  State<PinVerifyScreen> createState() => _PinVerifyScreenState();
}

class _PinVerifyScreenState extends State<PinVerifyScreen> {
  final _formKey = GlobalKey<FormState>();
  final _pinController = TextEditingController();

  Future<void> _pinVerify() async {
    final provider = context.read<PinVerifyProvider>();
    bool isSuccess = await provider.pinVerify(widget.email, _pinController.text);

    if (isSuccess) {
      showSnackBarMessage(context, 'Pin Verified Successfully', false);
      _goToResetPassword();
    } else {
      showSnackBarMessage(context, provider.errorMessage ?? 'Error', true);
    }
  }

  void _goToResetPassword() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ResetPasswordScreen(
          email: widget.email,
          otp: _pinController.text,
        ),
      ),
    );
  }

  void _goToLogin() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => LoginScreen()),
          (route) => false,
    );
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PinVerifyProvider(),
      builder: (context, child) => Scaffold(
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
                      'Pin Verification',
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
                    PinCodeTextField(
                      length: 6,
                      obscureText: false,
                      keyboardType: TextInputType.number,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        activeFillColor: Colors.white,
                      ),
                      animationDuration: Duration(milliseconds: 300),
                      backgroundColor: Colors.transparent,
                      controller: _pinController,
                      appContext: context,
                    ),
                    SizedBox(height: 20),
                    Consumer<PinVerifyProvider>(
                      builder: (context, provider, _) {
                        return FilledButton(
                          onPressed: () => _pinVerify(),
                          child: provider.isLoading
                              ? SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                              : Icon(Icons.arrow_circle_right_outlined),
                        );
                      }
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: 'Have an account? ',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                              text: 'Login',
                              style: TextStyle(color: Colors.green),
                              recognizer: TapGestureRecognizer()
                                ..onTap = _goToLogin,
                            ),
                          ],
                        ),
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
}