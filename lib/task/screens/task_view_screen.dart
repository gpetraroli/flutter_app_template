import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markdown_widget/markdown_widget.dart';

import '../providers/task_provider.dart';

import '../../core/widgets/account_popup_menu.dart';
import '../widgets/task_form.dart';
import '../widgets/task_footer.dart';

class TaskViewScreen extends ConsumerStatefulWidget {
  static final routeName = '/task/edit';

  const TaskViewScreen({super.key});

  @override
  ConsumerState<TaskViewScreen> createState() => _TaskViewScreenState();
}

class _TaskViewScreenState extends ConsumerState<TaskViewScreen> {
  bool isViewMode = true;

  @override
  Widget build(BuildContext context) {
    final taskId = ModalRoute.of(context)!.settings.arguments as int;

    final task = ref
        .watch(todosProvider)
        .value
        ?.firstWhere((task) => task.id == taskId);

    if (task == null) {
      return const Scaffold(
        body: Center(
          child: Text('Task not found'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text((task.title)),
        actions: [
          IconButton(
            onPressed: () {
              ref
                  .read(todosProvider.notifier)
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
              setState(() {
                isViewMode = !isViewMode;
              });
            },
            icon: Icon(isViewMode ? Icons.edit : Icons.library_books),
          ),
          AccountPopupMenu(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: isViewMode
            ? Column(
                children: [
                  Expanded(child: MarkdownWidget(data: task.body)),
                  TaskFooter(task: task),
                ],
              )
            : TaskForm(task: task),
      ),
    );
  }
}
