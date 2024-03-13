class ToDoTask {
  int? taskId;
  String title;
  String description;
  String date;
  int? taskDone;

  ToDoTask({
    required this.title,
    required this.description,
    required this.date,
    required this.taskDone,
  });
  ToDoTask.fromDB({
    required this.taskId,
    required this.title,
    required this.description,
    required this.date,
    required this.taskDone,
  });

  Map<String, dynamic> toMap() {
    return {
      'taskId': taskId,
      'title': title,
      'description': description,
      'date': date,
      'taskDone': taskDone,
    };
  }
}
