
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/inprogress_task_provider.dart';
import '../widgets/centered_progress_indicator.dart';
import '../widgets/task_card.dart';


class InProgressTaskScreen extends StatefulWidget {
  const InProgressTaskScreen({super.key});

  @override
  State<InProgressTaskScreen> createState() => _InprogressTaskScreenState();
}

class _InprogressTaskScreenState extends State<InProgressTaskScreen> {


  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<InprogressTaskProvider>().getTaskList();
    });
  }


  @override
  Widget build(BuildContext context) {
    final _inprogressTaskProvider = context.watch<InprogressTaskProvider>();
    return Scaffold(
      body: Visibility(
        visible: _inprogressTaskProvider.isLoading == false,
        replacement: CenteredProgressIndicator(),
        child: ListView.builder(
          itemCount: _inprogressTaskProvider.taskList.length,
          itemBuilder: (context, index){
            return TaskCard(
                refreshParent: _inprogressTaskProvider.getTaskList,
                title: _inprogressTaskProvider.taskList[index].title,
                description: _inprogressTaskProvider.taskList[index].description,
                color: Colors.orange,
                status: _inprogressTaskProvider.taskList[index].status,
                taskModel: _inprogressTaskProvider.taskList[index],
                createDate: _inprogressTaskProvider.taskList[index].createdDate
            );
          }
        ),
      ),
    );
  }
}
