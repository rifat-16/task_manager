import 'package:flutter/material.dart';
import 'package:task_manger/data/models/user_model.dart';
import 'package:task_manger/ui/widgets/photo_picker_field.dart';
import 'package:task_manger/ui/widgets/screen_background.dart';
import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';
import '../controller/auth_cotroller.dart';
import '../widgets/snack_bar_message.dart';
import '../widgets/tm_app_bar.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  bool _updateProfileInProgress = false;

  @override
  void initState() {
    super.initState();
    UserModel userModel = AuthController.userModel!;
    _emailTEController.text = userModel.email;
    _firstNameTEController.text = userModel.firstname;
    _lastNameTEController.text = userModel.lastname;
    _mobileTEController.text = userModel.mobile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TmAppBar(fromUpdateProfile: true),
      body: BackgroundScreen(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 80),
                    Text(
                      'Update Profile',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: 20),
                    PhotoPickerField(),
                    SizedBox(height: 10),
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
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _firstNameTEController,
                      decoration: InputDecoration(hintText: 'Fast Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'First Name is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _lastNameTEController,
                      decoration: InputDecoration(hintText: 'Last Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Last Name is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _mobileTEController,
                      decoration: InputDecoration(hintText: 'Phone Number'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Phone Number is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _passwordTEController,
                      decoration: InputDecoration(hintText: 'Password'),
                      validator: (value) {
                        if ((value != null && value.isNotEmpty) &&
                            value.length < 6) {
                          return 'Password is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    FilledButton(
                      onPressed: _updateProfile,
                      child: Visibility(
                        visible: _updateProfileInProgress == false,
                        replacement: CircularProgressIndicator(),
                        child: Icon(Icons.arrow_forward_ios),
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

  Future<void> _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _updateProfileInProgress = true;
      });
      Map<String, dynamic> body = {
        "email": _emailTEController.text,
        "firstName": _firstNameTEController.text,
        "lastName": _lastNameTEController.text,
        "mobile": _mobileTEController.text,
      };
      if (_passwordTEController.text.isNotEmpty) {
        body['password'] = _passwordTEController.text;
      }
      final ApiResponse response = await ApiCaller.postRequest(
        url: Urls.updateProfileUrl,
        body: body,
      );
      setState(() {
        _updateProfileInProgress = false;
      });
      if (response.isSuccess && response.responseData['status'] == 'success') {
        UserModel model = UserModel(
          id: AuthController.userModel!.id,
          email: _emailTEController.text,
          firstname: _firstNameTEController.text,
          lastname: _lastNameTEController.text,
          mobile: _mobileTEController.text,
        );
        AuthController.saveUserData(model, AuthController.accessToken!);
        showSnackBarMessage(context, 'Profile Updated Successfully', false);
      }
    }
  }


  @override
  void dispose() {
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
