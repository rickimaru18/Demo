import 'package:flutter/material.dart';
import 'package:morphosis_flutter_demo/non_ui/modal/task.dart';
import 'package:morphosis_flutter_demo/non_ui/providers/viewmodels/tasks_viewmodel.dart';
import 'package:morphosis_flutter_demo/ui/screens/task.dart';
import 'package:provider/provider.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({
    required this.title,
    this.isCompletedOnly = false,
    Key? key,
  }) : super(key: key);

  final String title;
  final bool isCompletedOnly;

  /// Navigate to [TaskPage].
  void _toTaskPage(BuildContext context, [Task? task]) => Navigator.pushNamed(
        context,
        TaskPage.route,
        arguments: task,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _toTaskPage(context),
          ),
        ],
      ),
      body: Consumer<TasksViewModel>(
        builder: (_, TasksViewModel viewModel, __) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final List<Task> tasks =
              isCompletedOnly ? viewModel.completedTasks : viewModel.tasks;

          if (tasks.isEmpty) {
            return const Center(child: Text('Add your first task'));
          }

          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (_, int i) {
              final Task task = tasks[i];

              return _Task(
                task,
                onTap: () => _toTaskPage(context, task),
                onComplete: () => viewModel.completeTask(task),
                onDelete: () => viewModel.deleteTask(task),
              );
            },
          );
        },
      ),
    );
  }
}

//------------------------------------------------------------------------------
class _Task extends StatelessWidget {
  const _Task(
    this.task, {
    this.onTap,
    this.onComplete,
    this.onDelete,
  });

  final Task task;
  final VoidCallback? onTap;
  final VoidCallback? onComplete;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconButton(
        icon: Icon(
          task.isCompleted ? Icons.check_box : Icons.check_box_outline_blank,
        ),
        onPressed: onComplete,
      ),
      title: Text(task.title),
      subtitle: Text(task.description),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: onDelete,
      ),
      onTap: onTap,
    );
  }
}
