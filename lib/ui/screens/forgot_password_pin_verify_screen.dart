

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manger/ui/screens/reset_password_screen.dart';
import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/screen_background.dart';
import '../widgets/snack_bar_message.dart';
import 'login_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinVerifyScreen extends StatefulWidget {
  final email;
  const PinVerifyScreen({super.key, required this.email});

  @override
  State<PinVerifyScreen> createState() => _PinVerifyScreenState();
}

class _PinVerifyScreenState extends State<PinVerifyScreen> {
  final _formKey = GlobalKey<FormState>();
  final _pinTEController = TextEditingController();
  bool _loginInProgress = false;


Future<void> _pinVerify() async{
  setState(() {
    _loginInProgress = true;
  });
  final ApiResponse response = await ApiCaller.getRequest(
    url: Urls.resetPasswordOtpUrl(widget.email, _pinTEController.text),
  );
  if (response.isSuccess && response.responseData['status'] == 'success') {
    showSnackBarMessage(context, 'Pin Verified Successfully', false);
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
                    'Pin Verification',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 10),
                  Text('A 6-digit code has been sent to your email',
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
                    animationType: AnimationType.fade,
                    keyboardType: TextInputType.number,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                    ),
                    animationDuration: Duration(milliseconds: 300),
                    backgroundColor: Colors.transparent,
                    controller: _pinTEController,
                    appContext: context,
                  ),
                  SizedBox(height: 20),
                  FilledButton(
                    onPressed: _pinVerify,
                    child: Visibility(
                        visible: _loginInProgress == false,
                        replacement: Center(child: CircularProgressIndicator()),
                        child: Icon(Icons.arrow_circle_right_outlined)),
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
  void _opTabLoginTextButton(){
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (__) => LoginScreen()), (route) => false);
  }

  void _onTabFilledButton(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (__) => ResetPasswordScreen(email: widget.email, otp: _pinTEController.text),),
    );
  }


  @override
  void dispose() {
    _pinTEController.dispose();
    super.dispose();
  }

}
