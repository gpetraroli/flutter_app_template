import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/widgets/account_popup_menu.dart';
import '../widgets/task_form.dart';

class TaskNewScreen extends ConsumerWidget {
  static final routeName = '/task/new';

  const TaskNewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      appBar: AppBar(title: const Text('New Task'), actions: [
        AccountPopupMenu(),
      ]),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TaskForm(),
      ),
    );
  }
}
