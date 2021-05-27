import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:morphosis_flutter_demo/non_ui/modal/task.dart';
import 'package:morphosis_flutter_demo/non_ui/providers/viewmodels/task_viewmodel.dart';
import 'package:provider/provider.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({
    this.task,
    Key? key,
  }) : super(key: key);

  static const String route = '/task';

  final Task? task;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(task == null ? 'New Task' : 'Edit Task'),
      ),
      body: _TaskForm(
        task,
        onSave: (Task task) async {
          await Provider.of<TaskViewModel>(context, listen: false).save(task);
          Navigator.pop(context);
        },
      ),
    );
  }
}

//------------------------------------------------------------------------------
class _TaskForm extends StatefulWidget {
  const _TaskForm(
    this.task, {
    this.onSave,
    Key? key,
  }) : super(key: key);

  final Task? task;
  final ValueChanged<Task>? onSave;

  @override
  __TaskFormState createState() => __TaskFormState();
}

class __TaskFormState extends State<_TaskForm> {
  static const double _padding = 16;

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late Task _task;

  @override
  void initState() {
    super.initState();
    _task = widget.task ?? Task();
    _titleController = TextEditingController(text: _task.title);
    _descriptionController = TextEditingController(text: _task.description);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(_padding),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Title',
              ),
            ),
            const SizedBox(height: _padding),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Description',
              ),
              minLines: 5,
              maxLines: 10,
            ),
            const SizedBox(height: _padding),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Completed ?'),
                CupertinoSwitch(
                  value: _task.isCompleted,
                  onChanged: (_) {
                    setState(() {
                      _task.toggleComplete();
                    });
                  },
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                _task.title = _titleController.text;
                _task.description = _descriptionController.text;
                widget.onSave?.call(_task);
              },
              child: SizedBox(
                width: double.infinity,
                child: Center(child: Text(_task.isNew ? 'Create' : 'Update')),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
