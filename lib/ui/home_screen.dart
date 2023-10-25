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
  HomeScreen({super.key});
  final RxString searchValue = ''.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Config.appName)),
      body: _body(context).marginAll(Measure.paddingLevel1),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _onAdd(context),
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Measure.borderRaduisl1)),
        icon: Icon(Icons.add, color: KColors.white),
        label: Text("Add", style: Get.textTheme.white13),
      ),
    );
  }

  Column _body(BuildContext context) {
    return Column(children: [
      SearchTextFieldBar(onSearch: (v) => controller.searchTodo(v)),
      Measure.paddingLevel1.height,
      _todoListLayout(context)
    ]);
  }

  Widget _todoListLayout(BuildContext context) {
    List list = controller.filterTodoList;

    return controller.obx(
      (state) => Expanded(
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
              })),
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
}

class SearchTextFieldBar extends StatelessWidget {
  final ValueChanged<String> onSearch;
  SearchTextFieldBar({
    required this.onSearch,
    super.key,
  });

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      onChanged: (value) => onSearch(value),
      decoration: InputDecoration(
        hintText: 'Search...',
        contentPadding: EdgeInsets.symmetric(
            vertical: Measure.paddingLevel1, horizontal: Measure.paddingLevel1),
        suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () => textEditingController.clear()),
        prefixIcon: const Icon(Icons.search),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: KColors.black),
            borderRadius: BorderRadius.circular(Measure.borderRaduisl1)),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: KColors.black),
          borderRadius: BorderRadius.circular(Measure.borderRaduisl1),
        ),
      ),
    );
  }
}
