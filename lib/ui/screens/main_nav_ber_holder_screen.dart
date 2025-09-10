import 'package:flutter/material.dart';

import '../widgets/tm_app_bar.dart';
import 'cancelled_task_screen.dart';
import 'completed_task_screen.dart';
import 'inprogress_task_screen.dart';
import 'new_task_screen.dart';

class MainNavBerHolderScreen extends StatefulWidget {
  const MainNavBerHolderScreen({super.key});

  @override
  State<MainNavBerHolderScreen> createState() => _MainNavBerHolderScreenState();
}

class _MainNavBerHolderScreenState extends State<MainNavBerHolderScreen> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = [
    NewTaskScreen(),
    InProgressTaskScreen(),
    CompletedTaskScreen(),
    CancelledTaskScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TmAppBar(),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: NavigationBar(
          height: 60,
          backgroundColor: Colors.white,
          elevation: 0,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          selectedIndex: _selectedIndex,
          onDestinationSelected: (int index){
            setState(() {
              _selectedIndex = index;
            });
          },
          animationDuration: Duration(milliseconds: 300),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.new_label,color: Colors.blue,), label: 'New',),
            NavigationDestination(icon: Icon(Icons.refresh,color: Colors.orange,), label: 'In Progress'),
            NavigationDestination(icon: Icon(Icons.check,color: Colors.green,), label: 'Completed'),
            NavigationDestination(icon: Icon(Icons.close,color: Colors.red,), label: 'Cancelled'),
          ]
      ),
    );
  }
}
