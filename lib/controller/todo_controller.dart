import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todo_project_demo/helper/endpoint.dart';
import 'package:todo_project_demo/model/todo_model.dart';

class TodoController extends GetxController with StateMixin<List<TodoModel>> {
  RxList<TodoModel> todoList = <TodoModel>[].obs;

  final CollectionReference<Map<String, dynamic>> db =
      FirebaseFirestore.instance.collection(Endpoint.todo);

  @override
  void onInit() {
    getTodoList();
    super.onInit();
  }

  Future getTodoList() async {
    var res = await db.get();

    todoList(res.docs.map((e) => TodoModel.fromJson(e.data())).toList());
    change(todoList, status: RxStatus.success());
    return;
  }

  Future removeTodo(TodoModel todo) async {
    db.doc(todo.uId).delete().then(
        (value) => todoList.removeWhere((element) => element.uId == todo.uId),
        onError: (E) => EasyLoading.showError(E));
  }

  Future editTodo(TodoModel todo, TodoModel newTodo) async {
    db.doc(todo.uId).update(newTodo.toJson()).then((value) {
      // update data by refresh todolist
      todo = newTodo;
      todoList.refresh();
    }, onError: (e) => EasyLoading.showError(e));
  }

  Future addTodo(TodoModel todo) async {
    // create new doc
    var doc = db.doc();
    // use doc id as uId
    todo.uId = doc.id;
    doc.set(todo.toJson()).then((value) => todoList.add(todo));
  }

  Future markTodo(TodoModel todo) async {
    var param = {'is_mark': todo.todoIsMark ? 0 : 1};

    db.doc(todo.uId).update(param).then((value) {
      // after success update new status
      todo.updateStatus();
      todoList.refresh();
    });
  }

  /// this func doesn't need request to firebase
  /// firlter in local
  List<TodoModel> searchTodo(String keyword) {
    if (keyword.isNotEmpty) {
      return todoList
          .where((element) => element.title!
              .toLowerCase()
              .contains(keyword.trim().toLowerCase()))
          .toList();
    }
    return todoList;
  }
}
