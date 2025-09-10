
import 'package:flutter/material.dart';
import 'package:task_manger/ui/widgets/tm_app_bar.dart';

import '../widgets/task_card.dart';
import '../widgets/task_count_by_status.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(padding: const EdgeInsets.all(20),
              child: SizedBox(
                height: 90,
                child: Row(
                  children: [
                    TaskCoundByStatus(title: 'New Task', count: '10'),
                    TaskCoundByStatus(title: 'In Progress', count: '20'),
                    TaskCoundByStatus(title: 'Completed', count: '30'),
                    TaskCoundByStatus(title: 'Cancelled', count: '40'),
                  ]
                ),
              )
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index){
                return TaskCard(status: 'New', color: Colors.blue,);
              }
            )
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.add),
      ),

    );
  }
}






