import 'dart:async';
import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:morphosis_flutter_demo/non_ui/modal/task.dart';
import 'package:morphosis_flutter_demo/non_ui/repo/firebase_manager.dart';

class TasksViewModel with ChangeNotifier {
  TasksViewModel() {
    _init();
  }

  /// All tasks.
  UnmodifiableListView<Task> get tasks => UnmodifiableListView(_tasks);
  final List<Task> _tasks = <Task>[];

  /// All completed tasks.
  UnmodifiableListView<Task> get completedTasks =>
      UnmodifiableListView(_tasks.where((Task task) => task.isCompleted));

  late StreamSubscription<List<Task>> _tasksStreamSub;

  /// Loading state.
  bool get isLoading => _isLoading;
  bool _isLoading = false;

  /// Initialization.
  void _init() {
    _isLoading = true;
    _tasksStreamSub = FirebaseManager().tasks.listen((List<Task> event) {
      if (_isLoading) {
        _isLoading = false;
      }

      _tasks.clear();
      _tasks.addAll(event);

      notifyListeners();
    });
  }

  /// Complete [task].
  Future<void> completeTask(Task task) async {
    task.toggleComplete();
    await FirebaseManager().updateTask(task);
  }

  /// Delete [task].
  Future<void> deleteTask(Task task) async {
    await FirebaseManager().deleteTask(task);
  }

  @override
  Future<void> dispose() async {
    await _tasksStreamSub.cancel();
    super.dispose();
  }
}
