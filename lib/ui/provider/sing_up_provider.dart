import 'package:flutter/material.dart';

import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';

class SignUpProvider extends ChangeNotifier{
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> signUp(String email, String firstName, String lastName, String phoneNumber, String password) async {
    bool isSuccess = false;
    _isLoading = true;
    notifyListeners();
    Map<String, dynamic> body = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": phoneNumber,
      "password": password,
    };
    final ApiResponse response = await ApiCaller.postRequest(
      url: Urls.registrationUrl,
      body: body,
    );
    if (response.isSuccess && response.responseData['status'] == 'success') {
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
