import 'package:flutter/material.dart';

import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';

class AddNewTaskProvider extends ChangeNotifier{
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;


  Future<bool> addTask(String subject, String description) async {
    bool isSuccess = false;
    _isLoading = true;
    notifyListeners();

    Map<String, dynamic> body = {
      "status": "New",
      "title": subject,
      "description": description,
    };
    final ApiResponse response = await ApiCaller.postRequest(
      url: Urls.addTaskUrl,
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