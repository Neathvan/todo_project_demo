import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_project_demo/controller/todo_controller.dart';
import 'package:todo_project_demo/helper/colors.dart';
import 'package:todo_project_demo/helper/config.dart';
import 'package:todo_project_demo/helper/k_extension.dart';
import 'package:todo_project_demo/model/todo_model.dart';
import 'package:todo_project_demo/ui/component/add_task_dialog.dart';
import 'package:todo_project_demo/ui/component/search_text_field_bar.dart';
import 'package:todo_project_demo/ui/component/task_cell.dart';

class HomeScreen extends GetView<TodoController> {
  HomeScreen({super.key});
  final RxString searchValue = ''.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Config.appName)),
      body: _body(context).marginAll(Measure.paddingLevel1),
      floatingActionButton: _floatActionBtn(context),
    );
  }

  FloatingActionButton _floatActionBtn(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => _onAdd(context),
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Measure.borderRaduisl1)),
      icon: Icon(Icons.add, color: KColors.white),
      label: Text("Add", style: Get.textTheme.white13),
    );
  }

  Column _body(BuildContext context) {
    return Column(children: [
      // search bar
      SearchTextFieldBar(onSearch: (v) => searchValue(v)),
      Measure.paddingLevel1.height,
      // taks layout
      controller.obx((state) {
        return Obx(() {
          return _todoListLayout(context);
        });
      })
    ]);
  }

  Widget _todoListLayout(BuildContext context) {
    // filter list
    List list = controller.searchTodo(searchValue.value);

    // layout
    if (list.isEmpty) return _emptyLayout();
    return _tasksLayout(list, context);
  }

  Expanded _tasksLayout(List<dynamic> list, BuildContext context) {
    return Expanded(
        child: ListView.builder(
            padding: EdgeInsets.zero,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            itemCount: list.length,
            itemBuilder: (_, i) {
              var task = list[i];
              return TaskCell(
                  onEdit: () => _onEdit(context, task),
                  onMark: () => _onMark(task),
                  onRemove: () => _onRemove(task),
                  todoModel: task);
            }));
  }

  Text _emptyLayout() {
    return Text("No result", style: Get.textTheme.black15Bold);
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
}
