import 'package:flutter/material.dart';
import 'package:maids/providers/task_provider.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../../models/task_model.dart';
import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
      ),
      body: NotificationListener(
        onNotification: (notification) {
          if (notification is ScrollEndNotification &&
              notification.metrics.extentAfter == 0) {
            viewModel.getMoreTasks();
          }
          return false;
        },
        child: RefreshIndicator(
            onRefresh: () => viewModel.refreshTasks(),
            child: Consumer<TaskProvider>(builder: (_, taskProvider, child) {
              return taskProvider.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(color: Colors.blue),
                    )
                  : ListView.builder(
                      itemCount: taskProvider.tasks.length,
                      itemBuilder: (_, index) {
                        if (index < taskProvider.tasks.length) {
                          final task = taskProvider.tasks.elementAt(index);
                          return GestureDetector(
                            onTap: viewModel.navigateToDetailsScreen(task),
                            child: _TodoListTile(task),
                          );
                        }
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24),
                            child: taskProvider.hasMore && taskProvider.tasks.isNotEmpty
                                ? const CircularProgressIndicator(color: Colors.blue)
                                : CircleAvatar(
                              radius: 5,
                              backgroundColor: Colors.grey.withOpacity(0.7),
                            ),
                          ),
                        );
                      },
                    );
            })),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          viewModel.navigateToAddTaskScreen();
        },
        tooltip: 'Add todo',
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel(context: context);
}

class _TodoListTile extends StatelessWidget {
  const _TodoListTile(this.todo);

  final TaskModel? todo;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        todo?.todo ?? '',
        style: TextStyle(
          decoration:
              todo?.completed ?? false ? TextDecoration.lineThrough : null,
        ),
      ),
    );
  }
}
