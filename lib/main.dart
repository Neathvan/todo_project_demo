import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_project_demo/controller/todo_controller.dart';
import 'package:todo_project_demo/ui/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Todo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      initialBinding: MyAppBinding(),
      home: HomeScreen(),
    );
  }
}

class MyAppBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TodoController>(() => TodoController());
  }
}
