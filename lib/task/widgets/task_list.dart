import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/task_provider.dart';
import './task_list_item.dart';

class TaskList extends ConsumerWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(tasksProvider);

    return tasksAsync.when(
      data: (tasks) {
        if (tasks.isEmpty) {
          return const Center(child: Text('No tasks found'));
        }

        final activeTasks = tasks.where((t) => t.completedAt == null).toList();
        final completedTasks = tasks.where((t) => t.completedAt != null).toList();

        return ListView(
          children: [
            ...activeTasks.map((task) => TaskListItem(task: task)),
            const Divider(height: 32),
            Center(child: Text('Completed (${completedTasks.length})')),
            ...completedTasks.map((task) => TaskListItem(task: task)),
          ],
        );
      },
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
