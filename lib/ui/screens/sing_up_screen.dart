
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manger/data/services/api_caller.dart';
import 'package:task_manger/data/utils/urls.dart';
import 'package:task_manger/ui/widgets/snack_bar_message.dart';

import '../widgets/centered_progress_indicator.dart';
import '../widgets/screen_background.dart';

class SingupScreen extends StatefulWidget {
  const SingupScreen({super.key});

  @override
  State<SingupScreen> createState() => _SingupScreenState();
}

class _SingupScreenState extends State<SingupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailTEController = TextEditingController();
  final _passwordTEController = TextEditingController();
  final _firstNameTEController = TextEditingController();
  final _lastNameTEController = TextEditingController();
  final _phoneNumberTEController = TextEditingController();

  bool _singUpInProgress = false;

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
                      decoration: InputDecoration(hintText: 'Email'),
                      validator: (value){
                        if(value == null || value.isEmpty || !value.contains('@gmail.com') ){
                          return 'Email is required';
                        }
                        return null;
                      }

                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _firstNameTEController,
                    decoration: InputDecoration(hintText: 'First Name'),
                    validator: (value){
                      if(value?.trim().isEmpty ?? true){
                        return 'Fast Name is required';
                      }
                      return null;
                    },

                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _lastNameTEController,
                    decoration: InputDecoration(hintText: 'Last Name'),
                    validator: (value){
                      if(value?.trim().isEmpty ?? true){
                        return 'Last Name is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _phoneNumberTEController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: 'Phone Number'),
                    validator: (value){
                      if(value?.trim().isEmpty ?? true){
                        return 'Phone Number is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                      controller: _passwordTEController,
                      obscureText: true,
                      decoration: InputDecoration(hintText: 'Password'),
                      validator: (value){
                        if(value == null || value.isEmpty || value.length < 6){
                          return 'Password is required';
                        }
                        return null;
                      }
                  ),
                  SizedBox(height: 20),
                  Visibility(
                    visible: _singUpInProgress == false,
                    replacement: CenteredProgressIndicator(),
                    child: FilledButton(
                      onPressed: _onTabFilledButton,
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
  void _onTabFilledButton(){
    if(_formKey.currentState!.validate()){
      _signUp();
    }
  }

  void _opTabLoginTextButton() {
    Navigator.pop(context);
  }

  Future<void> _signUp() async {
    setState(() {
      _singUpInProgress = true;
    });
    Map<String, dynamic> body = {
      "email":_emailTEController.text,
      "firstName":_firstNameTEController.text,
      "lastName":_lastNameTEController.text,
      "mobile":_phoneNumberTEController.text,
      "password":_passwordTEController.text,
    };
    final ApiResponse response = await ApiCaller.postRequest(
      url: Urls.registrationUrl,
      body: body,
    );
    setState(() {
      _singUpInProgress = false;
    });
    if(response.isSuccess){
      _clearTextFields();
      showSnackBarMessage(context, 'Registration Success' , false);
    }else{
      showSnackBarMessage(context, response.errorMessage! , true);
    }
  }

  void _clearTextFields(){
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
