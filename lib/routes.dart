import 'package:flutter/material.dart';
import 'package:morphosis_flutter_demo/non_ui/modal/task.dart';
import 'package:morphosis_flutter_demo/non_ui/providers/viewmodels/task_viewmodel.dart';
import 'package:morphosis_flutter_demo/non_ui/providers/viewmodels/tasks_viewmodel.dart';
import 'package:morphosis_flutter_demo/ui/screens/index.dart';
import 'package:morphosis_flutter_demo/ui/screens/task.dart';
import 'package:provider/provider.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  // Route to [IndexPage].
  IndexPage.route: (_) => ChangeNotifierProvider<TasksViewModel>(
        create: (_) => TasksViewModel(),
        child: const IndexPage(),
      ),

  // Route to [TaskPage]
  TaskPage.route: (BuildContext context) {
    final Task? task = ModalRoute.of(context)!.settings.arguments as Task?;

    return Provider<TaskViewModel>(
      create: (_) => TaskViewModel(),
      child: TaskPage(task: task),
    );
  },
};
