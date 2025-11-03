import 'package:flutter/widgets.dart';

import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';

class PinVerifyProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  Future<bool> pinVerify(String email, String otp) async {
    bool isSuccess = false;
    final ApiResponse response = await ApiCaller.getRequest(
      url: Urls.resetPasswordOtpUrl(email, otp),
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
