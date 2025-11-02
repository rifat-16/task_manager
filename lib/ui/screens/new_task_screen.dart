import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manger/ui/controller/new_task_provider.dart';
import 'package:task_manger/ui/screens/add_new_task_screen.dart';
import '../widgets/centered_progress_indicator.dart';
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
    Future.microtask(() {
      final provider = context.read<NewTaskProvide>();
      provider.getAllTaskStatusCount();
      provider.getTaskList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final newTaskProvider = context.watch<NewTaskProvide>();
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<NewTaskProvide>().getAllTaskStatusCount();
          await context.read<NewTaskProvide>().getTaskList();
        },
        child: Column(
          children: [
            SizedBox(height: 90,
              child: Visibility(
                visible: newTaskProvider.isLoading == false,
                replacement: CenteredProgressIndicator(),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: newTaskProvider.taskStatusCountList.length,
                  itemBuilder: (context, index) {
                    final item = newTaskProvider.taskStatusCountList[index];
                    return TaskCoundByStatus(
                      title: item.status,
                      count: item.count.toString(),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: newTaskProvider.taskList.length,
                itemBuilder: (context, index){
                  final task = newTaskProvider.taskList[index];
                  return TaskCard(
                      refreshParent: (){
                        newTaskProvider.getTaskList();
                        newTaskProvider.getAllTaskStatusCount();
                      },
                      title: task.title,
                      description: task.description,
                      color: Colors.blue,
                      status: task.status,
                      taskModel: task,
                      createDate: task.createdDate
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
