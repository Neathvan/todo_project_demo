import 'package:flutter/material.dart';
import 'package:todo_project_demo/helper/colors.dart';

class TodoModel {
  TodoModel(
      {this.id = 0, this.isEdit = 0, this.isMark = 0, this.status, this.title});

  int id;
  int isEdit, isMark;
  String? title, status;

  bool get todoIsEdit => isEdit.isNegative;
  bool get todoIsMark => isMark.isOdd;

  updateStatus() {
    if (todoStatus == TodoStatus.incomplete) {
      isMark = 1;
      return status = TodoStatus.completed.keyword;
    }
    isMark = 0;
    return status = TodoStatus.incomplete.keyword;
  }

  TodoStatus get todoStatus =>
      TodoStatus.values.firstWhere((element) => element.keyword == status,
          orElse: () => TodoStatus.incomplete);
}

enum TodoStatus {
  completed('completed'),
  incomplete('incomplete');

  MaterialColor get statusColor {
    return switch (this) {
      incomplete => KColors.red,
      completed => KColors.green,
    };
  }

  String get title {
    return switch (this) {
      incomplete => 'completed',
      completed => 'incomplete',
    };
  }

  const TodoStatus(this.keyword);
  final String keyword;
}
