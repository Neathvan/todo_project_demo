import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_project_demo/controller/todo_controller.dart';
import 'package:todo_project_demo/helper/colors.dart';
import 'package:todo_project_demo/helper/config.dart';
import 'package:todo_project_demo/helper/k_extension.dart';
import 'package:todo_project_demo/model/todo_model.dart';
import 'package:todo_project_demo/ui/component/add_task_dialog.dart';
import 'package:todo_project_demo/ui/component/task_cell.dart';

class HomeScreen extends GetView<TodoController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Config.appName)),
      body: _body(context),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _onAdd(context),
        backgroundColor: Colors.black,
        icon: Icon(
          Icons.add,
          color: KColors.white,
        ),
        label: Text(
          "Add",
          style: Get.textTheme.white13,
        ),
      ),
    );
  }

  Column _body(BuildContext context) {
    return Column(children: [TextField(), _todoListLayout(context)]);
  }

  Widget _todoListLayout(BuildContext context) {
    return controller.obx(
      (state) => Expanded(
          child: ListView.builder(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              itemCount: controller.todoList.length,
              itemBuilder: (_, i) {
                var task = controller.todoList[i];
                return TaskCell(
                    onEdit: () => _onEdit(context, task),
                    onMark: () => _onMark(task),
                    onRemove: () => _onRemove(task),
                    todoModel: task);
              }).marginAll(Measure.paddingLevel2)),
    );
  }

  _onEdit(BuildContext context, TodoModel task) {
    return showDialog(
        context: context,
        builder: (context) {
          return AddTaskDialog(
            todoModel: task,
          );
        }).then((value) => controller.editTodo(task, value));
  }

  _onMark(TodoModel task) {
    controller.markTodo(task);
  }

  _onRemove(TodoModel task) {
    controller.removeTodo(task);
  }

  _onAdd(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return const AddTaskDialog();
        }).then((value) => controller.addTodo(value));
  }

  _onSearch(k) {}
}
