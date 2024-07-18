import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../app/app.locator.dart';
import '../models/task_model.dart';
import '../services/local_storage.dart';
import '../services/remote_services.dart';

class TaskProvider with ChangeNotifier {
  final _remoteService = locator<RemoteServices>();
  List<TaskModel> tasks = [];
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  int page = 0, limit = 10;
  bool hasMore = true;

  Future<void> fetchTasks() async {
    if (page == 0) toggleLoading(true);
    try {

      // Check if tasks are available in local storage first
      if (page == 0) {
        List<TaskModel>? savedTasks = await LocalStorage.loadTasks();
        if (savedTasks != null && savedTasks.isNotEmpty) {
          tasks.addAll(savedTasks);
          if (savedTasks.length < limit) hasMore = false;
          toggleLoading(false);
          return;
        }
      }

      List<TaskModel>? newTasks = await _remoteService
          .fetchTasks(
            limit: limit,
            skip: limit * page,
          )
          .timeout(const Duration(seconds: 15));
      if (newTasks == null) {
        /*showDialog(
          context: navigatorKey.currentContext!,
          builder: (context) => kCheckConnectionDialog,
        );*/
      } else {
        if (newTasks.length < 10) hasMore = false;
        tasks.addAll(newTasks);
        await LocalStorage.saveTasks(newTasks);
      }
    } on TimeoutException {
      /*showDialog(
        context: navigatorKey.currentContext!,
        builder: (context) => kTimeoutDialog,
      );*/
    } catch (e) {
      //
    } finally {
      toggleLoading(false);
    }
    page++;
  }

  Future<void> addTask(TaskModel task) async {
    await _remoteService.addTask(task);
    tasks.add(task);
    LocalStorage.saveTasks(tasks);
    notifyListeners();
  }

  Future<void> updateTask(TaskModel task) async {
    await _remoteService.updateTask(task.id, task.completed);
    final index = tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      tasks[index] = task;
      await LocalStorage.saveTasks(tasks);
      notifyListeners();
    }
  }

  Future<void> deleteTask(int id) async {
    await _remoteService.deleteTask(id);
    tasks.removeWhere((task) => task.id == id);
    await LocalStorage.saveTasks(tasks);
    notifyListeners();
  }

  void toggleLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
