import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_project_demo/helper/colors.dart';
import 'package:todo_project_demo/helper/k_extension.dart';
import 'package:todo_project_demo/model/todo_model.dart';

class TaskCell extends StatelessWidget {
  final TodoModel todoModel;
  final VoidCallback onRemove, onEdit, onMark;
  const TaskCell(
      {super.key,
      required this.todoModel,
      required this.onRemove,
      required this.onEdit,
      required this.onMark});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: EdgeInsets.all(Measure.paddingLevel2),
      margin: EdgeInsets.symmetric(vertical: Measure.paddingLevel2),
      decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(Measure.borderRaduisl1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Checkbox(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                  value: todoModel.todoIsMark,
                  // splashRadius: 0,
                  onChanged: (v) => onMark()),
              Expanded(
                child: Text(
                  todoModel.title!,
                  style: Get.textTheme.black15Bold.copyWith(
                      decoration: todoModel.todoIsMark
                          ? TextDecoration.lineThrough
                          : null),
                ),
              )
            ],
          ),
          Measure.paddingLevel2.height,
          Row(
            children: [
              _buildBtn(KColors.green,
                  icon: Icons.edit, name: 'Edit', callback: onEdit),
              Measure.paddingLevel1.width,
              _buildBtn(KColors.red,
                  icon: Icons.edit, name: 'Remove', callback: onRemove),
              const Spacer(),
              Text(
                todoModel.todoStatus.keyword.capitalizeFirst!,
                style: Get.textTheme.black13Bold
                    .copyWith(color: todoModel.todoStatus.statusColor),
              )
            ],
          )
        ],
      ),
    );
  }

  ElevatedButton _buildBtn(Color backgroundColor,
      {required String name,
      required IconData icon,
      required VoidCallback callback}) {
    return ElevatedButton.icon(
      onPressed: callback,
      style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Measure.borderRaduisl1))),
      icon: Icon(
        Icons.edit,
        size: 16,
        color: KColors.white,
      ),
      label: Text(
        name,
        style: Get.textTheme.white13,
      ),
    );
  }
}
