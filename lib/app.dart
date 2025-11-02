import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manger/ui/controller/auth_cotroller.dart';
import 'package:task_manger/ui/provider/cancelled_task_provider.dart';
import 'package:task_manger/ui/provider/completed_task_provider.dart';
import 'package:task_manger/ui/provider/inprogress_task_provider.dart';
import 'package:task_manger/ui/provider/new_task_provider.dart';
import 'package:task_manger/ui/provider/update_profile_provider.dart';
import 'package:task_manger/ui/screens/splash_screen.dart';


class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> NewTaskProvide()),
        ChangeNotifierProvider(create: (_)=> InprogressTaskProvider()),
        ChangeNotifierProvider(create: (_)=> CompletedTaskProvider()),
        ChangeNotifierProvider(create: (_)=> CancelledTaskProvider()),
        ChangeNotifierProvider(create: (_)=> UpdateProfileProvider()),
        ChangeNotifierProvider(create: (_)=> AuthController()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Task Manager',
        theme: ThemeData(
          colorSchemeSeed: Colors.green,
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
              ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
              ),
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
          textTheme: TextTheme(
            titleLarge: TextStyle(
              color: Colors.black,
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
          ),
          filledButtonTheme: FilledButtonThemeData(
            style: FilledButton.styleFrom(
              minimumSize: Size(double.infinity, 50),
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            )
          )
        ),
        home: SplashScreen(),
      ),
    );
  }
}
