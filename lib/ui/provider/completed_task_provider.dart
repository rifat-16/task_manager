import 'package:flutter/cupertino.dart';

import '../../data/models/task_model.dart';
import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';

class CompletedTaskProvider extends ChangeNotifier{
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  List<TaskModel> _taskList = [];
  List<TaskModel> get taskList => _taskList;
  Future<bool> getTaskList() async {
    bool isSuccess = false;
    _isLoading = true;
    notifyListeners();
    final ApiResponse response = await ApiCaller.getRequest(
      url: Urls.completedTaskUrl,
    );
    if (response.isSuccess && response.responseData['status'] == 'success'){
      List<TaskModel> list = [];
      for (Map<String, dynamic> jsonData in response.responseData['data']){
        list.add(TaskModel.fromJson(jsonData));
      }
      _taskList = list;
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