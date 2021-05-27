// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:morphosis_flutter_demo/non_ui/modal/task.dart';
import 'package:morphosis_flutter_demo/ui/screens/task.dart';

void main() {
  testWidgets('New task', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: TaskPage(),
    ));

    // Verify that TaskPage's default display has empty title and description.
    expect(find.text('test title'), findsNothing);
    expect(find.text('test description'), findsNothing);

    await tester.enterText(find.byKey(const Key('title')), 'test title');
    await tester.enterText(
        find.byKey(const Key('description')), 'test description');
    await tester.pump();

    // Verify that title and description has been inputted.
    expect(find.text('test title'), findsOneWidget);
    expect(find.text('test description'), findsOneWidget);
  });

  testWidgets('Update task', (WidgetTester tester) async {
    final Task task = Task()
      ..id = 'test'
      ..title = 'test title'
      ..description = 'test description';

    await tester.pumpWidget(MaterialApp(
      home: TaskPage(task: task),
    ));

    // Verify that TaskPage's default display contains the task's title and description.
    expect(find.text('test title'), findsOneWidget);
    expect(find.text('test description'), findsOneWidget);

    // Tap the completed switch.
    await tester.tap(find.byType(CupertinoSwitch));
    await tester.pump();

    // Verify that task is completed.
    expect(task.completedAt, isNotNull);
  });
}
