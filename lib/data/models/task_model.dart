class TaskModel {
  final int id;
  final String title;
  final bool isCompleted;

  TaskModel({required this.id, required this.title, required this.isCompleted});

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'] ?? '',
      isCompleted: json['completed'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "title": title, "completed": isCompleted};
  }
}
