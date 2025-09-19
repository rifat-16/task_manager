import 'package:flutter/material.dart';
import 'package:task_manger/ui/widgets/photo_picker_field.dart';
import 'package:task_manger/ui/widgets/screen_background.dart';

import '../widgets/tm_app_bar.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TmAppBar(
        fromUpdateProfile: true,
      ),
      body: BackgroundScreen(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 80,),
                  Text('Update Profile',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 20,),
                  PhotoPickerPield(),
                  SizedBox(height: 10,),
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Email'),
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Fast Name'),
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Last Name'),
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Phone Number'),
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Password'),
                  ),
                  SizedBox(height: 20,),
                  FilledButton(onPressed: (){}, child: Icon(Icons.arrow_forward_ios))

                ]
              ),
            ),
          ),
        ),
      ),
    );
  }
}


