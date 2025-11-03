import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manger/ui/widgets/snack_bar_message.dart';
import '../provider/sing_up_provider.dart';
import '../widgets/centered_progress_indicator.dart';
import '../widgets/screen_background.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailTEController = TextEditingController();
  final _passwordTEController = TextEditingController();
  final _firstNameTEController = TextEditingController();
  final _lastNameTEController = TextEditingController();
  final _phoneNumberTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignUpProvider>(
      create: (_) => SignUpProvider(),
      builder: (context, child) {
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
                      const SizedBox(height: 100),
                      Text(
                        'Create Your Account',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _emailTEController,
                        decoration: const InputDecoration(hintText: 'Email'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _firstNameTEController,
                        decoration: const InputDecoration(hintText: 'First Name'),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'First Name is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _lastNameTEController,
                        decoration: const InputDecoration(hintText: 'Last Name'),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Last Name is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _phoneNumberTEController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(hintText: 'Phone Number'),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Phone Number is required';
                          }
                          if (!RegExp(r'^\+?\d{7,15}$').hasMatch(value.trim())) {
                            return 'Enter a valid phone number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _passwordTEController,
                        obscureText: true,
                        decoration: const InputDecoration(hintText: 'Password'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      Consumer<SignUpProvider>(
                        builder: (context, provider, child) {
                          if (provider.isLoading) {
                            return CenteredProgressIndicator();
                          }
                          return FilledButton(
                            onPressed: () => _onTabFilledButton(context),
                            child: const Icon(Icons.arrow_circle_right_outlined),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            text: 'Have an account? ',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                text: 'Login',
                                style: const TextStyle(color: Colors.green),
                                recognizer: TapGestureRecognizer()..onTap = _opTabLoginTextButton,
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
    );
  }

  Future<void> _onTabFilledButton(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final provider = context.read<SignUpProvider>();
      final isSuccess = await provider.signUp(
        _emailTEController.text.trim(),
        _firstNameTEController.text.trim(),
        _lastNameTEController.text.trim(),
        _phoneNumberTEController.text.trim(),
        _passwordTEController.text,
      );
      if (isSuccess) {
        showSnackBarMessage(context, 'Successfully Registered', false);
        _clearTextFields();
        Navigator.pop(context);
      } else {
        showSnackBarMessage(context, provider.errorMessage ?? 'Registration failed', true);
      }
    }
  }

  void _opTabLoginTextButton() {
    Navigator.pop(context);
  }

  void _clearTextFields() {
    _emailTEController.clear();
    _passwordTEController.clear();
    _firstNameTEController.clear();
    _lastNameTEController.clear();
    _phoneNumberTEController.clear();
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _phoneNumberTEController.dispose();
    super.dispose();
  }
}
