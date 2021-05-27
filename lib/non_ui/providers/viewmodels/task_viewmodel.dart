import 'package:morphosis_flutter_demo/non_ui/modal/task.dart';
import 'package:morphosis_flutter_demo/non_ui/repo/firebase_manager.dart';
import 'package:uuid/uuid.dart';

class TaskViewModel {
  /// Save [task] to Firestore.
  Future<void> save(Task task) async {
    task.id ??= const Uuid().v1();
    task.title = task.title.trim();
    task.description = task.description.trim();
    await FirebaseManager().addTask(task);
  }
}
