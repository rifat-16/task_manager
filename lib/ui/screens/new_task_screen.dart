

import 'package:flutter/material.dart';
import 'package:task_manger/ui/screens/add_new_task_screen.dart';
import '../../data/models/task_model.dart';
import '../../data/models/task_status_count.dart';
import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/centered_progress_indicator.dart';
import '../widgets/snack_bar_message.dart';
import '../widgets/task_card.dart';
import '../widgets/task_count_by_status.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  void initState() {
    super.initState();
    _getAllTaskStatusCount();
    _getTaskList();
  }

  bool _getTaskListInProgress = false;
  List<TaskStatusCount> _taskStatusCountList = [];
  List<TaskModel> _taskList = [];

  Future<void> _getAllTaskStatusCount() async {
    setState(() {
      _getTaskListInProgress = true;
    });
    final ApiResponse response = await ApiCaller.getRequest(
      url: Urls.taskStatusCountUrl,
    );
    setState(() {
      _getTaskListInProgress = false;
    });
    if (response.isSuccess && response.responseData['status'] == 'success') {
      List<TaskStatusCount> list = [];
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        list.add(TaskStatusCount.fromJson(jsonData));
      }
      _taskStatusCountList = list;
    } else {
      showSnackBarMessage(context, response.errorMessage!, true,);
    }
    setState(() {
      _getTaskListInProgress = false;
    });
  }

  Future<void> _getTaskList() async {
    setState(() {
      _getTaskListInProgress = true;
    });
    final ApiResponse response = await ApiCaller.getRequest(
      url: Urls.newTaskUrl,
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
      body: RefreshIndicator(
        onRefresh: (){
          _getAllTaskStatusCount();
          _getTaskList();
          return Future.delayed(Duration(seconds: 1));
        },
        child: Column(
          children: [
            SizedBox(height: 90,
              child: Visibility(
                visible: _getTaskListInProgress == false,
                replacement: CenteredProgressIndicator(),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _taskStatusCountList.length,
                  itemBuilder: (context, index) {
                    return TaskCoundByStatus(
                      title: _taskStatusCountList[index].status,
                      count: _taskStatusCountList[index].count.toString(),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _taskList.length,
                itemBuilder: (context, index){
                  return TaskCard(
                      refreshParent: (){
                        _getTaskList();
                        _getAllTaskStatusCount();
                      },
                      title: _taskList[index].title,
                      description: _taskList[index].description,
                      color: Colors.blue,
                      status: _taskList[index].status,
                      taskModel: _taskList[index],
                      createDate: _taskList[index].createdDate
                  );
                }
              )
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onTabFloatingActionButton,
        child: Icon(Icons.add),
      ),

    );
  }

  void _onTabFloatingActionButton(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> AddNewTaskScreen()));
  }
}
