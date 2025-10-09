import 'package:flutter/material.dart';

import '../../data/models/task_model.dart';
import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/centered_progress_indicator.dart';
import '../widgets/snack_bar_message.dart';
import '../widgets/task_card.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  @override
  void initState() {
    super.initState();
    _getTaskList();
  }


  bool _getTaskListInProgress = false;

  List<TaskModel> _taskList = [];

  Future<void> _getTaskList() async {
    setState(() {
      _getTaskListInProgress = true;
    });
    final ApiResponse response = await ApiCaller.getRequest(
      url: Urls.completedTaskUrl,
    );
    setState(() {
      _getTaskListInProgress = false;
    });
    if (response.isSuccess && response.responseData['status'] == 'success') {
      List<TaskModel> list = [];
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }
      _taskList = list;
    } else {
      showSnackBarMessage(context, response.errorMessage!, true,);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Visibility(
        visible: _getTaskListInProgress == false,
        replacement: CenteredProgressIndicator(),
        child: ListView.builder(
            itemCount: _taskList.length,
            itemBuilder: (context, index){
              return TaskCard(
                  refreshParent: _getTaskList,
                  title: _taskList[index].title,
                  description: _taskList[index].description,
                  color: Colors.orange,
                  status: _taskList[index].status,
                  taskModel: _taskList[index],
                  createDate: _taskList[index].createdDate
              );
            }
        ),
      ),
    );
  }
}
