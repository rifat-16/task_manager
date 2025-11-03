import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manger/ui/widgets/centered_progress_indicator.dart';
import '../provider/reset_password_provider.dart';
import '../widgets/screen_background.dart';
import '../widgets/snack_bar_message.dart';
import 'login_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  final email;
  final otp;
  const ResetPasswordScreen({super.key, this.email, this.otp});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _newPassTEController = TextEditingController();
  final _confirmPassTEController = TextEditingController();

  Future<void> _setPassword(ResetPasswordProvider provider) async {
    if (_formKey.currentState!.validate()) {
      if (_newPassTEController.text == _confirmPassTEController.text) {
        bool isSuccess = await provider.setPassword(
          widget.email,
          widget.otp,
          _newPassTEController.text,
        );
        if (isSuccess) {
          showSnackBarMessage(context, 'Password Reset Successfully', false);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (__) => LoginScreen()),
                (route) => false,
          );
        } else {
          final errorMessage = provider.errorMessage;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(errorMessage ?? 'Error')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Passwords do not match")),
        );
      }
    }
  }

  void _opTabLoginTextButton() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (__) => LoginScreen()),
          (route) => false,
    );
  }

  @override
  void dispose() {
    _newPassTEController.dispose();
    _confirmPassTEController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Provider ke builder er vitore wrap kora holo, so context access hobe.
    return ChangeNotifierProvider<ResetPasswordProvider>(
      create: (_) => ResetPasswordProvider(),
      child: Builder(
        builder: (context) {
          final provider = context.watch<ResetPasswordProvider>();

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
                          decoration:
                          InputDecoration(hintText: 'New Password'),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _confirmPassTEController,
                          obscureText: true,
                          decoration:
                          InputDecoration(hintText: 'Confirm Password'),
                        ),
                        SizedBox(height: 20),
                        provider.isLoading
                            ? Center(child: CenteredProgressIndicator())
                            : FilledButton(
                          onPressed: () => _setPassword(provider),
                          child: Icon(Icons.arrow_circle_right_outlined),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: RichText(
                            text: TextSpan(
                              text: 'Have an account? ',
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
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}