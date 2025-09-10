import 'package:flutter/material.dart';
import 'package:task_manger/ui/widgets/screen_background.dart';
import 'package:task_manger/ui/widgets/tm_app_bar.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _subjectTEController = TextEditingController();
  final _descriptionTEController = TextEditingController();

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 80,),
                  Text('Add New Task', style: Theme.of(context).textTheme.titleLarge),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: _subjectTEController,
                    decoration: InputDecoration(hintText:'Subject'),),
                  SizedBox(height: 10,),
                  TextFormField(
                    maxLines: 5,
                    controller: _descriptionTEController,
                    decoration: InputDecoration(hintText: 'Description'),),
                  SizedBox(height: 20,),
                  FilledButton(onPressed: (){}, child: Icon(Icons.arrow_forward_ios))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  @override
  void dispose() {
    _subjectTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }
}
