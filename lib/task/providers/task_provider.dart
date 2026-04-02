import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../auth/providers/auth_provider.dart';
import '../models/task.dart';

final tasksProvider = StreamNotifierProvider<TasksNotifier, List<Task>>(() {
  return TasksNotifier();
});

class TasksNotifier extends StreamNotifier<List<Task>> {
  @override
  Stream<List<Task>> build() {
    final session = ref.watch(authProvider).unwrapPrevious().value;
    if (session == null) {
      return Stream.value([]);
    }

    final supabase = Supabase.instance.client;

    return supabase
        .from('tasks')
        .stream(primaryKey: ['id'])
        .order('created_at', ascending: false)
        .map((data) => data.map((json) => Task.fromJson(json)).toList());
  }

  Future<void> createTask(String title, String body) async {
    final supabase = Supabase.instance.client;
    final user = Supabase.instance.client.auth.currentUser;

    if (user == null) {
      throw Exception('User not authenticated');
    }

    await supabase.from('tasks').insert({
      'title': title,
      'body': body,
      'user_id': user.id,
    });
  }

  Future<void> updateTask(int id, String title, String body) async {
    final supabase = Supabase.instance.client;
    await supabase
        .from('tasks')
        .update({
          'title': title,
          'body': body,
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('id', id);
  }

  Future<void> setCompletedAt(int id, DateTime? completedAt) async {
    final supabase = Supabase.instance.client;
    await supabase
        .from('tasks')
        .update({'completed_at': completedAt?.toIso8601String()})
        .eq('id', id);
  }

  Future<void> deleteTask(int id) async {
    final supabase = Supabase.instance.client;
    await supabase.from('tasks').delete().eq('id', id);
  }
}
