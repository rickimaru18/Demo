import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:morphosis_flutter_demo/env.dart';
import 'package:morphosis_flutter_demo/non_ui/modal/task.dart';

class FirebaseManager {
  factory FirebaseManager() {
    return _one ??= FirebaseManager._();
  }

  FirebaseManager._();

  static FirebaseManager? _one;

  bool _isInit = false;

  /// Initialize Firebase.
  Future<void> initialise() async {
    if (_isInit) {
      return;
    }

    await Firebase.initializeApp();
    _isInit = true;
  }

  /// Tasks collection reference.
  CollectionReference get _tasksRef =>
      FirebaseFirestore.instance.collection(Env.firestoreTasksCollection);

  /// Get tasks from Firestore.
  Stream<List<Task>> get tasks => _tasksRef
      .orderBy('id', descending: true)
      .snapshots()
      .map((event) => event.docs
          .map((e) => Task.fromJson(e.data()! as Map<String, dynamic>))
          .toList());

  /// Add [task] to Firestore.
  Future<void> addTask(Task task) => _tasksRef.doc(task.id).set(task.toJson());

  /// Update [task] from Firestore.
  Future<void> updateTask(Task task) => addTask(task);

  /// Delete [task] from Firestore.
  Future<void> deleteTask(Task task) => _tasksRef.doc(task.id).delete();
}
