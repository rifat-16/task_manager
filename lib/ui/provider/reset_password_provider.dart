import 'package:flutter/widgets.dart';
import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';

class ResetPasswordProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  Future<bool> setPassword(String email, String otp, String password) async {
    bool isSuccess = false;
    final ApiResponse response = await ApiCaller.postRequest(
      url: Urls.setNewPasswordUrl,
      body: {"email": email, "OTP": otp, "password": password},
    );
    if (response.isSuccess && response.responseData['status'] == 'success') {
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    notifyListeners();
    return isSuccess;
  }
}
