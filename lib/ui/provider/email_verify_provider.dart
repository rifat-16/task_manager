import 'package:flutter/foundation.dart';

import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';

class EmailVerifyProvider extends ChangeNotifier{
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> emailVerify(String email) async {
    bool isSuccess = false;
    _isLoading = true;
    notifyListeners();
    final ApiResponse response = await ApiCaller.getRequest(
      url: Urls.forgotPasswordUrl(email),
    );
    if(response.isSuccess && response.responseData['status'] == 'success'){
      _errorMessage = null;
      isSuccess = true;
    }
    else{
      _errorMessage = response.errorMessage;
    }
    _isLoading = false;
    notifyListeners();
    return isSuccess;
  }
}
