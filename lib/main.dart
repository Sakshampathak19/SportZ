import 'package:flutter/material.dart';
import 'package:flutter_proj/Welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        datePickerTheme: const DatePickerThemeData(
          cancelButtonStyle: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(Colors.deepPurple),
          ),
          confirmButtonStyle: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(Colors.deepPurple),
          ),
          rangePickerHeaderForegroundColor: Colors.white,
          headerBackgroundColor: Colors.deepPurple,
          headerForegroundColor: Colors.white,
          yearForegroundColor: WidgetStatePropertyAll(Colors.black),
          dayOverlayColor: WidgetStatePropertyAll(Colors.deepPurple),
          rangePickerBackgroundColor: Colors.deepPurple,
          todayBackgroundColor: WidgetStatePropertyAll(Colors.deepPurple),
          rangeSelectionBackgroundColor: Colors.deepPurple,
          todayForegroundColor: WidgetStatePropertyAll(Colors.white),
        ),
      ),
      home: const Welcome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

