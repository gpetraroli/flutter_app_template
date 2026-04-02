import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../providers/task_provider.dart';

import '../screens/task_view_screen.dart';

import '../models/task.dart';

class TaskListItem extends ConsumerWidget {
  final Task task;
  const TaskListItem({super.key, required this.task});

  void _onDismissed(DismissDirection direction, ref) async {
    await ref.read(tasksProvider.notifier).deleteTask(task.id);
  }

  Future<bool> _onConfirmDismiss(
    BuildContext context,
    DismissDirection direction,
  ) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Delete"),
          content: const Text("Are you sure you want to delete this task?"),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: Key(task.id.toString()),
      direction: DismissDirection.startToEnd,
      confirmDismiss: (direction) async {
        return await _onConfirmDismiss(context, direction);
      },
      onDismissed: (direction) => _onDismissed(direction, ref),
      background: Container(
        color: Colors.red,
        padding: const EdgeInsets.only(left: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 10,
          children: [
            const Icon(Icons.delete, color: Colors.white),
            Expanded(
              child: Text(
                task.title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white),
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
      child: ListTile(
        title: Text(task.title, overflow: TextOverflow.ellipsis, maxLines: 1),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(DateFormat('yyyy-MM-dd - HH:mm').format(task.createdAt)),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                ref
                    .read(tasksProvider.notifier)
                    .setCompletedAt(
                      task.id,
                      task.completedAt != null ? null : DateTime.now(),
                    );
              },
              icon: Icon(
                task.completedAt != null
                    ? Icons.check_circle
                    : Icons.pending_actions,
                color: task.completedAt != null ? Colors.green : null,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  TaskViewScreen.routeName,
                  arguments: task.id,
                );
              },
              icon: Icon(Icons.visibility),
            ),
          ],
        ),
      ),
    );
  }
}
