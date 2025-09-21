
import 'package:flutter/material.dart';

void showSnackBarMessage(BuildContext context, String message , bool isError){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: isError ? Colors.red : Colors.green,
      duration: Duration(seconds: 1),
    ),
  );
}