import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_project_demo/controller/todo_controller.dart';
import 'package:todo_project_demo/helper/config.dart';
import 'package:todo_project_demo/helper/k_extension.dart';
import 'package:todo_project_demo/model/todo_model.dart';
import 'package:todo_project_demo/ui/component/task_cell.dart';

class HomeScreen extends GetView<TodoController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Config.appName)),
      body: Column(children: [
        TextField(),
        controller.obx(
          (state) => Expanded(
              child: ListView.builder(
                  itemCount: controller.todoList.length,
                  itemBuilder: (_, i) {
                    var task = controller.todoList[i];
                    return TaskCell(
                        onEdit: () => _onEdit(task),
                        onMark: () => _onMark(task),
                        onRemove: () => _onRemove(task),
                        todoModel: task);
                  }).marginAll(Measure.paddingLevel2)),
        )
      ]),
    );
  }

  _onEdit(TodoModel task) {}
  _onMark(TodoModel task) {
    controller.markTodo(task);
  }

  _onRemove(TodoModel task) {
    controller.removeTodo(task);
  }

  _onAdd(TodoModel task) {}
  _onSearch(k) {}
}
