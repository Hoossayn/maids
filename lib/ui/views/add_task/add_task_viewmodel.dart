import 'package:flutter/cupertino.dart';
import 'package:maids/app/app.router.dart';
import 'package:maids/models/task_model.dart';
import 'package:maids/utilities/constants.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';
import '../../../providers/task_provider.dart';

class AddTaskViewModel extends BaseViewModel {
  bool _isCompleted = false;

  bool get isCompleted => _isCompleted;

  final _navigationService = locator<NavigationService>();


  void addTask(BuildContext context, TaskModel model) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TaskProvider>(context, listen: false).addTask(model);
    });
    _navigationService.navigateToHomeView();
  }

  void setCompleted(bool isCompleted) {
    _isCompleted = isCompleted;
    rebuildUi();
  }

  Future<int?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(userId);
  }
}
