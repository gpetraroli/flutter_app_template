import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../auth/providers/auth_provider.dart';
import '../../auth/screens/login_screen.dart';

class AccountPopupMenu extends ConsumerWidget {
  const AccountPopupMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final username = Supabase.instance.client.auth.currentUser?.email ?? '';

    final items = <PopupMenuEntry>[];

    if (username.isNotEmpty) {
      items.add(PopupMenuItem(
        enabled: false,
        child: Text(username),
      ));

    }

    items.add(PopupMenuItem(
      onTap: () async {
        await ref.read(authProvider.notifier).signOut();
        if (context.mounted) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            LoginScreen.routeName,
            (route) => false,
          );
        }
      },
      child: Text('Logout'),
    ));

    items.add(PopupMenuDivider());

    items.add(PopupMenuItem(
      onTap: () async {
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('About'),
            content: Text('Version 0.1.0'),
            actions: [
              TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('OK')),
            ],
          ),
        );
      },
      child: Text('About'),
    ));

    return PopupMenuButton(
      icon: const Icon(Icons.person),
      tooltip: username,
      itemBuilder: (context) => items,
    );
  }
}
