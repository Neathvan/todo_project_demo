import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_project_demo/controller/todo_controller.dart';
import 'package:todo_project_demo/helper/colors.dart';
import 'package:todo_project_demo/helper/k_extension.dart';
import 'package:todo_project_demo/model/todo_model.dart';

class AddTaskDialog extends StatefulWidget {
  final TodoModel? todoModel;
  const AddTaskDialog({super.key, this.todoModel});

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  late TodoModel todoModel;
  final TextEditingController addController = TextEditingController();
  final TodoController controller = Get.find<TodoController>();
  final FocusNode _focusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  @override
  void initState() {
    todoModel = widget.todoModel ?? TodoModel();
    if (widget.todoModel != null) {
      addController.text = todoModel.title!;
    }
    super.initState();
  }

  @override
  void dispose() {
    addController.dispose();
    super.dispose();
  }

  String get alertTitle {
    return widget.todoModel == null ? 'Add new task' : 'Edit task';
  }

  String get submitTitle {
    return 'Submit';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Measure.borderRaduisl1)),
      title: Text(alertTitle, style: Get.textTheme.black17Bold),
      content: SizedBox(
        width: double.maxFinite,
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: addController,
                  focusNode: _focusNode,
                  maxLines: null,
                  autofocus: true,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: Measure.paddingLevel1,
                          horizontal: Measure.paddingLevel1),
                      errorBorder: _outlineInputBorder(),
                      enabledBorder: _outlineInputBorder(),
                      focusedBorder: _outlineInputBorder(),
                      focusedErrorBorder: _outlineInputBorder(true)),
                  validator: (text) {
                    // check dulicate item
                    final duplicate = controller.todoList
                        .any((element) => element.title == text!.trim());

                    // msg
                    if (text == null || text.trim().isEmpty) {
                      return "Please fill out the field";
                    } else if (duplicate) {
                      return "This task title already exist!";
                    }
                    return null;
                  },
                )
              ],
            ),
          ),
        ),
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              final isValid = _form.currentState!.validate();

              if (isValid) {
                todoModel.title = addController.text.trim();
                return Get.back(result: todoModel.clone());
              }
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: KColors.green,
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(Measure.borderRaduisl1))),
            child: Text(
              submitTitle,
              style: Get.textTheme.white13,
            ))
      ],
    );
  }

  OutlineInputBorder _outlineInputBorder([bool error = false]) =>
      OutlineInputBorder(
          borderSide: BorderSide(color: error ? KColors.red : KColors.black));
}
