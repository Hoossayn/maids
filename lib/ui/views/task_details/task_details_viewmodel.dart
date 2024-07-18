import 'package:flutter/cupertino.dart';
import 'package:maids/app/app.router.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../models/task_model.dart';
import '../../../providers/task_provider.dart';

class TaskDetailsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  void deleteTask(BuildContext context, TaskModel model) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TaskProvider>(context, listen: false).deleteTask(model.id);
    });
    _navigationService.navigateToHomeView();
  }

  void navigateToUpdateTask(TaskModel taskModel){
    _navigationService.navigateToUpdateTaskView(task: taskModel);
  }
}
