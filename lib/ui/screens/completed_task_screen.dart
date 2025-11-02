import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/task_model.dart';
import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';
import '../provider/completed_task_provider.dart';
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
    Future.microtask(() {
      context.read<CompletedTaskProvider>().getTaskList();
    });
  }


  @override
  Widget build(BuildContext context) {
    final _completedTaskProvider = context.watch<CompletedTaskProvider>();
    return Scaffold(
      body: Visibility(
        visible: _completedTaskProvider.isLoading == false,
        replacement: CenteredProgressIndicator(),
        child: ListView.builder(
            itemCount: _completedTaskProvider.taskList.length,
            itemBuilder: (context, index){
              return TaskCard(
                  refreshParent: _completedTaskProvider.getTaskList,
                  title: _completedTaskProvider.taskList[index].title,
                  description: _completedTaskProvider.taskList[index].description,
                  color: Colors.orange,
                  status: _completedTaskProvider.taskList[index].status,
                  taskModel: _completedTaskProvider.taskList[index],
                  createDate: _completedTaskProvider.taskList[index].createdDate
              );
            }
        ),
      ),
    );
  }
}
