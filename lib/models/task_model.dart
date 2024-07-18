import 'dart:convert';

class TaskModels {
  TaskModels({required this.todos});

  List<TaskModel> todos;

  factory TaskModels.fromJson(Map<String, dynamic> json) => TaskModels(
      todos: List<TaskModel>.from(
          json['todos'].map((x) => TaskModel.fromJson(x))));
}

class TaskModel {
  final int id;
  final String todo;
  bool completed;
  final int userId;

  TaskModel({
    required this.id,
    required this.todo,
    required this.completed,
    required this.userId,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json["id"],
        todo: json["todo"],
        completed: json["completed"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "todo": todo,
        "completed": completed,
        "userId": userId,
      };
}

List<TaskModel> taskModelFromJson(String str) =>
    List<TaskModel>.from(json.decode(str).map((x) => TaskModel.fromJson(x)));

String taskModelToJson(List<TaskModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
