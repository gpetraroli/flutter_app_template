import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import './auth/providers/auth_provider.dart';

import './themes/light_theme.dart';
import './auth/screens/login_screen.dart';
import './auth/screens/sign_up_screen.dart';
import './task/screens/task_index_screen.dart';
import './task/screens/task_new_screen.dart';
import './task/screens/task_view_screen.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env', overrideWithFiles: ['.env.override']);

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  runApp(const ProviderScope(child: App()));
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App template',
      theme: lightTheme,
      home: authState.when(
        data: (session) {
          return session != null
              ? const TaskIndexScreen()
              : const LoginScreen();
        },
        loading: () =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
        error: (err, stack) => const LoginScreen(),
      ),
      routes: {
        // Auth
        LoginScreen.routeName: (context) => const LoginScreen(),
        SignUpScreen.routeName: (context) => const SignUpScreen(),

        // Task
        TaskIndexScreen.routeName: (context) => const TaskIndexScreen(),
        TaskNewScreen.routeName: (context) => const TaskNewScreen(),
        TaskViewScreen.routeName: (context) => const TaskViewScreen(),
      },
    );
  }
}
