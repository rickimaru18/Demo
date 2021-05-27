import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:morphosis_flutter_demo/non_ui/modal/task.dart';
import 'package:morphosis_flutter_demo/non_ui/repo/firebase_manager.dart';

class TaskPage extends StatelessWidget {
  TaskPage({this.task});

  final Task? task;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(task == null ? 'New Task' : 'Edit Task'),
      ),
      body: _TaskForm(task),
    );
  }
}

class _TaskForm extends StatefulWidget {
  _TaskForm(this.task);

  final Task? task;

  @override
  __TaskFormState createState() => __TaskFormState();
}

class __TaskFormState extends State<_TaskForm> {
  static const double _padding = 16;

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late Task _task;

  void init() {
    _task = widget.task ?? Task();
    _titleController = TextEditingController(text: _task.title);
    _descriptionController = TextEditingController(text: _task.description);
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  void _save(BuildContext context) {
    //TODO implement save to firestore

    FirebaseManager.shared.addTask(_task);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(_padding),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Title',
              ),
            ),
            SizedBox(height: _padding),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Description',
              ),
              minLines: 5,
              maxLines: 10,
            ),
            SizedBox(height: _padding),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Completed ?'),
                CupertinoSwitch(
                  value: widget.task?.isCompleted ?? false,
                  onChanged: (_) {
                    setState(() {
                      _task.toggleComplete();
                    });
                  },
                ),
              ],
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () => _save(context),
              child: Container(
                width: double.infinity,
                child: Center(child: Text(_task.isNew ? 'Create' : 'Update')),
              ),
            )
          ],
        ),
      ),
    );
  }
}
