import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/task.dart';

class TaskFooter extends StatelessWidget {
  final Task task;

  const TaskFooter({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16.0,
      runSpacing: 8.0,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 4.0,
          children: [
            Icon(Icons.access_time),
            Text(DateFormat('yyyy-MM-dd - HH:mm').format(task.createdAt)),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 4.0,
          children: [
            Icon(
              task.completedAt != null
                  ? Icons.check_circle
                  : Icons.pending_actions,
              color: task.completedAt != null ? Colors.green : null,
            ),
            task.completedAt != null
                ? Text(
                    DateFormat('yyyy-MM-dd - HH:mm').format(task.completedAt!),
                  )
                : Text('Not completed'),
          ],
        ),
      ],
    );
  }
}
