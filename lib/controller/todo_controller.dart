import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:todo_project_demo/model/todo_model.dart';

class TodoController extends GetxController with StateMixin<List<TodoModel>> {
  List<TodoModel> todoList = [];

  @override
  void onInit() {
    getTodoList();
    super.onInit();
  }

  Future getTodoList() async {
    todoList = List.generate(
        10,
        (index) => TodoModel(
              id: index,
              title: "title $index",
            ));

    change(todoList, status: RxStatus.success());
    return;
  }

  Future removeTodo(TodoModel todo) async {
    todoList.removeWhere((element) => element.id == todo.id);
    update();
  }

  Future editTodo(TodoModel todo) async {
    update();
  }

  Future addTodo(TodoModel todo) async {
    update();
  }

  Future searchTodo(TodoModel todo) async {
    update();
  }

  Future markTodo(TodoModel todo) async {
    todo.updateStatus();
    update();
  }
}
