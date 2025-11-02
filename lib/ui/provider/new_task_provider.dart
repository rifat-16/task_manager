import 'package:flutter/cupertino.dart';

import '../../data/models/task_model.dart';
import '../../data/models/task_status_count.dart';
import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';

class NewTaskProvide extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  List<TaskStatusCount> _taskStatusCountList = [];
  List<TaskStatusCount> get taskStatusCountList => _taskStatusCountList;
  List<TaskModel> _taskList = [];
  List<TaskModel> get taskList => _taskList;

  Future<bool> getAllTaskStatusCount() async {
    bool isSuccess = false;
    _isLoading = true;
    notifyListeners();

    final ApiResponse response = await ApiCaller.getRequest(
      url: Urls.taskStatusCountUrl,
    );
    if (response.isSuccess && response.responseData['status'] == 'success') {
      List<TaskStatusCount> list = [];
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        list.add(TaskStatusCount.fromJson(jsonData));
      }
      _taskStatusCountList = list;
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _isLoading = false;
    notifyListeners();
    return isSuccess;

  }

  Future<bool> getTaskList() async {
    bool isSuccess = false;
    _isLoading = true;
    notifyListeners();

    final ApiResponse response = await ApiCaller.getRequest(
      url: Urls.newTaskUrl,
    );
    if (response.isSuccess && response.responseData['status'] == 'success') {
      List<TaskModel> list = [];
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
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