import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../models/task_model.dart';
import 'task_details_viewmodel.dart';

class TaskDetailsView extends StackedView<TaskDetailsViewModel> {
  final TaskModel task;
  const TaskDetailsView(this.task, {Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    TaskDetailsViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo'),
        actions: [
          IconButton(
            onPressed: () {
              viewModel.deleteTask(context, task);
            },
            icon: const Icon(Icons.delete),
            color: Colors.red,
            tooltip: 'Delete',
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (_, index) {
          final records = [
            (label: 'Todo', text: task.todo),
            (label: 'User ID', text: task.userId.toString()),
            (
              label: 'Status',
              text: task.completed ? 'Completed' : 'Not completed'
            ),
          ];
          final record = records[index];
          return ListTile(
            title: Text(record.label),
            subtitle: Text(record.text),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          viewModel.navigateToUpdateTask(task);
        },
        tooltip: 'Edit',
        child: const Icon(Icons.edit),
      ),
    );
  }

  @override
  TaskDetailsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      TaskDetailsViewModel();
}
