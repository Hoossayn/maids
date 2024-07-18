import 'package:flutter/cupertino.dart';
import 'package:maids/app/app.router.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../models/task_model.dart';
import '../../../providers/task_provider.dart';

class UpdateTaskViewModel extends BaseViewModel {
  bool _isCompleted = false;

  bool get isCompleted => _isCompleted;

  final _navigationService = locator<NavigationService>();

  void updateTask(BuildContext context, TaskModel model) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TaskProvider>(context, listen: false).updateTask(model);
    });
    _navigationService.navigateToHomeView();
  }

  void setCompleted(TaskModel model, bool isCompleted) {
    model.completed = isCompleted;
    _isCompleted = isCompleted;
    notifyListeners();
  }

}
