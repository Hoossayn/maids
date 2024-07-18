import 'dart:convert';
import 'package:maids/models/task_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import '../utilities/constants.dart';

class LocalStorage {
  static Future<void> saveTasks(List<TaskModel> tasks) async {
    List<String> tasksJson =
        tasks.map((task) => jsonEncode(task.toJson())).toList();
    prefs.setStringList(taskKey, tasksJson);
    loadTasks();
  }

  static Future<List<TaskModel>> loadTasks() async {
    List<String>? tasksJson = prefs.getStringList(taskKey);
    if (tasksJson != null) {
      return tasksJson
          .map((task) => TaskModel.fromJson(jsonDecode(task)))
          .toList();
    }
    return [];
  }
}
