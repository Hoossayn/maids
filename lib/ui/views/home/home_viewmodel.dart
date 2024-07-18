import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:maids/app/app.locator.dart';
import 'package:maids/app/app.router.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../models/task_model.dart';
import '../../../providers/task_provider.dart';
import '../../../services/remote_services.dart';

class HomeViewModel extends FutureViewModel<List<TaskModel?>> {
  HomeViewModel({required this.context});

  final BuildContext context;
  final _navigationService = locator<NavigationService>();



  Future<void> refreshTasks() async {
    getMoreTasks();
  }

  void getMoreTasks() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TaskProvider>(context, listen: false).fetchTasks();
    });
  }

  Function() navigateToDetailsScreen(TaskModel? model) {
    return () {
      _navigationService.navigateToTaskDetailsView(task: model!);
    };
  }

  void navigateToAddTaskScreen() {
    _navigationService.navigateToAddTaskView();
  }

  @override
  Future initialise() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TaskProvider>(context, listen: false).fetchTasks();
    });
    return super.initialise();
  }

  @override
  Future<List<TaskModel?>> futureToRun() {
    // TODO: implement futureToRun
    throw UnimplementedError();
  }
}
