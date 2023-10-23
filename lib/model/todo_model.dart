class TodoModel {
  TodoModel({this.id = 0, this.isEdit = false});

  int id;
  bool isEdit;
  String? title, status;

  TodoStatus get todoStatus =>
      TodoStatus.values.firstWhere((element) => element.keyword == status,
          orElse: () => TodoStatus.incomplete);
}

enum TodoStatus {
  completed('completed'),
  incomplete('incomplete');

  const TodoStatus(this.keyword);
  final String keyword;
}
