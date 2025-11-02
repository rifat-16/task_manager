import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cancelled_task_provider.dart';
import '../widgets/centered_progress_indicator.dart';
import '../widgets/task_card.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<CancelledTaskProvider>().getTaskList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final _cancelledTaskProvider = context.watch<CancelledTaskProvider>();
    return Scaffold(
      body: Visibility(
        visible: _cancelledTaskProvider.isLoading == false,
        replacement: CenteredProgressIndicator(),
        child: ListView.builder(
            itemCount: _cancelledTaskProvider.taskList.length,
            itemBuilder: (context, index){
              return TaskCard(
                  refreshParent: _cancelledTaskProvider.getTaskList,
                  title: _cancelledTaskProvider.taskList[index].title,
                  description: _cancelledTaskProvider.taskList[index].description,
                  color: Colors.orange,
                  status: _cancelledTaskProvider.taskList[index].status,
                  taskModel: _cancelledTaskProvider.taskList[index],
                  createDate: _cancelledTaskProvider.taskList[index].createdDate
              );
            }
        ),
      ),
    );
  }
}
