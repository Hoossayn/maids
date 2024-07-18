import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:maids/ui/views/update_task/update_task_view.form.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../../../models/task_model.dart';
import '../../widgets/primary_button.dart';
import 'update_task_viewmodel.dart';

@FormView(
  fields: [
    FormTextField(name: 'todo'),
    FormTextField(name: 'userId'),
  ],
)
class UpdateTaskView extends StackedView<UpdateTaskViewModel> with $UpdateTaskView {
  final TaskModel task;
  const UpdateTaskView(this.task, {Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    UpdateTaskViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Todo'),
      ),
      body: SingleChildScrollView(
        child: SeparatedColumn(
          padding: const EdgeInsets.all(24),
          separatorBuilder: () => const Gap(16),
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              readOnly: true,
              controller: TextEditingController(text: task.todo),
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
              selected: {task.completed},
              onSelectionChanged: (value) => viewModel.setCompleted(task, value.first),
              showSelectedIcon: false,
            ),
            const Gap(8),
            PrimaryButton(
              title: 'Update Task',
              onTap: () {
                viewModel.updateTask(
                    context,
                    TaskModel(
                        id: task.id,
                        todo: task.todo,
                        completed: viewModel.isCompleted,
                        userId: task.userId
                    ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  UpdateTaskViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      UpdateTaskViewModel();
}
