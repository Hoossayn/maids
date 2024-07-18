import 'dart:math';

import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:maids/models/task_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../../widgets/primary_button.dart';
import 'add_task_viewmodel.dart';
import 'add_task_view.form.dart';

@FormView(
  fields: [
    FormTextField(name: 'todo'),
  ],
)
class AddTaskView extends StackedView<AddTaskViewModel> with $AddTaskView {
  const AddTaskView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AddTaskViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Todo'),
      ),
      body: SingleChildScrollView(
        child: SeparatedColumn(
          padding: const EdgeInsets.all(24),
          separatorBuilder: () => const Gap(16),
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: todoController,
              decoration: const InputDecoration(
                  labelText: 'Todo',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
              ),
              textInputAction: TextInputAction.next,
              minLines: 5,
              maxLines: 5,

            ),
            const Gap(16),
            SegmentedButton(
              segments: const [
                ButtonSegment(
                  value: false,
                  label: Text('Not completed'),
                  icon: Icon(Icons.close),
                ),
                ButtonSegment(
                  value: true,
                  label: Text('Completed'),
                  icon: Icon(Icons.check),
                ),
              ],
              selected: {viewModel.isCompleted},
              onSelectionChanged: (value) {
                viewModel.setCompleted(value.first);
              },
              showSelectedIcon: false,
            ),
            const Gap(8),
            PrimaryButton(
              title: 'Add New Task',
              onTap: () async {
                viewModel.addTask(
                    context,
                    TaskModel(
                        id: Random().nextInt(100),
                        todo: todoController.text,
                        completed: viewModel.isCompleted,
                        userId: await viewModel.getUserId() ?? 1 ));
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  AddTaskViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AddTaskViewModel();
}
