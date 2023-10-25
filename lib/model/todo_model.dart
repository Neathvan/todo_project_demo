import 'package:flutter/material.dart';
import 'package:todo_project_demo/helper/colors.dart';

class TodoModel {
  TodoModel(
      {this.id = 0,
      this.isEdit = 0,
      this.isMark = 0,
      this.status = 'incomplete',
      this.title});

  int? id;
  String? uId = '';
  int? isEdit, isMark;
  String? title, status, detail;

  bool get todoIsEdit => isEdit!.isNegative;
  bool get todoIsMark => isMark!.isOdd;

  TodoModel clone() => TodoModel.fromJson(toJson());

  TodoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    uId = json['u_id'];
    isEdit = json['is_edit'];
    isMark = json['is_mark'];
    title = json['title'];
    status = json['status'];
    detail = json['detail'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['u_id'] = uId;
    data['is_edit'] = isEdit;
    data['is_mark'] = isMark;
    data['title'] = title;
    data['status'] = status;
    data['detail'] = detail ?? '';
    return data;
  }

  updateStatus() {
    if (todoStatus == TodoStatus.incomplete) {
      isMark = 1;
      return status = TodoStatus.completed.keyword;
    }
    isMark = 0;
    return status = TodoStatus.incomplete.keyword;
  }

  TodoStatus get todoStatus {
    if (todoIsMark) {
      return TodoStatus.completed;
    }
    return TodoStatus.incomplete;
  }
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
