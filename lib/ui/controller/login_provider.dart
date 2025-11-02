import 'package:flutter/material.dart';
import '../../data/models/user_model.dart';
import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';
import 'auth_cotroller.dart';

class LoginProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> login(String email, String password) async {
    bool isSuccess = false;
    _isLoading = true;
    notifyListeners();

    Map<String, dynamic> body = {
      "email": email,
      "password": password,
    };
    final ApiResponse response = await ApiCaller.postRequest(
      url: Urls.loginUrl,
      body: body,
    );
    if (response.isSuccess && response.responseData['status'] == 'success') {
      UserModel userModel = UserModel.fromJson(response.responseData['data']);
      String accessToken = response.responseData['token'];
      await AuthController.saveUserData(userModel, accessToken);

      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _isLoading = false;
    notifyListeners();
    return isSuccess;
  }
}
