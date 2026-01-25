import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import './task_new_screen.dart';

import '../../core/widgets/account_popup_menu.dart';
import '../widgets/task_list.dart';

class TaskIndexScreen extends ConsumerWidget {
  static final routeName = '/task';

  const TaskIndexScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      appBar: AppBar(title: const Text('Tasks'), actions: [
        AccountPopupMenu(),
      ]),
      body: TaskList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, TaskNewScreen.routeName);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
