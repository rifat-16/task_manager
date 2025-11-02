import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manger/ui/provider/add_new_task_provider.dart';
import 'package:task_manger/ui/widgets/screen_background.dart';
import 'package:task_manger/ui/widgets/tm_app_bar.dart';
import '../provider/new_task_provider.dart';
import '../widgets/centered_progress_indicator.dart';
import '../widgets/snack_bar_message.dart';


class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _subjectTEController = TextEditingController();
  final _descriptionTEController = TextEditingController();

  final AddNewTaskProvider _addNewTaskProvider = AddNewTaskProvider();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TmAppBar(),
      body: BackgroundScreen(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 80),
                  Text(
                    'Add New Task',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _subjectTEController,
                    decoration: InputDecoration(hintText: 'Subject'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Subject is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    maxLines: 5,
                    controller: _descriptionTEController,
                    decoration: InputDecoration(hintText: 'Description'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Description is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  Consumer(
                    builder: (context, value, _) {
                      return Visibility(
                        visible: _addNewTaskProvider.isLoading == false,
                        replacement: CenteredProgressIndicator(),
                        child: FilledButton(
                          onPressed: _onSubmit,
                          child: Icon(Icons.arrow_forward_ios),
                        ),
                      );
                    }
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      _addTask();
    }
  }

  Future<void> _addTask() async {
    final isSuccess = await _addNewTaskProvider.addTask(
    _subjectTEController.text.trim(),
    _subjectTEController.text.trim()
    );
    if(isSuccess){
      context.read<NewTaskProvide>().getTaskList();
      context.read<NewTaskProvide>().getAllTaskStatusCount();
      showSnackBarMessage(context, 'Task Add Successfully', false);
      _clearTextFields();
      Future.delayed(Duration(seconds: 2));
      Navigator.pop(context);
    }
    else{
      showSnackBarMessage(context, _addNewTaskProvider.errorMessage!, true);
    }
  }

  void _clearTextFields() {
    _subjectTEController.clear();
    _descriptionTEController.clear();
  }

  @override
  void dispose() {
    _subjectTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }
}
