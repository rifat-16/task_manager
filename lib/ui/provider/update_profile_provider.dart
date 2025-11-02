import 'package:flutter/cupertino.dart';

import '../../data/models/user_model.dart';
import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';
import '../controller/auth_cotroller.dart';

class UpdateProfileProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<void> updateProfile(String email, String firstName, String lastName,
      String mobile, String password) async {
    _isLoading = true;
    notifyListeners();
    Map<String, dynamic> body = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
    };
    if (password.isNotEmpty) {
      body['password'] = password;
    }
    try {
      final ApiResponse response = await ApiCaller.postRequest(
        url: Urls.updateProfileUrl,
        body: body,
      );
      if (response.isSuccess && response.responseData['status'] == 'success') {
        UserModel model = UserModel(
          id: AuthController.userModel!.id,
          email: email,
          firstname: firstName,
          lastname: lastName,
          mobile: mobile,
        );
        AuthController.saveUserData(model, AuthController.accessToken!);
        _errorMessage = null;
      }
      else {
        _errorMessage = response.errorMessage ?? 'Something went wrong!';
      }
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
    }
  }
}
