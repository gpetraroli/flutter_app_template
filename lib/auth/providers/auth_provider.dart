import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final authProvider = StreamNotifierProvider<AuthNotifier, Session?>(() {
  return AuthNotifier();
});

class AuthNotifier extends StreamNotifier<Session?> {
  @override
  Stream<Session?> build() {
    return Supabase.instance.client.auth.onAuthStateChange.map((data) {
      return data.session;
    });
  }
  
  Future<void> signIn(String email, String password) async {
      await Supabase.instance.client.auth.signInWithPassword(
        email: email, 
        password: password
      );
  }

  Future<void> signUp(String email, String password) async {
    await Supabase.instance.client.auth.signUp(
      email: email,
      password: password
    );
  }

    Future<void> signOut() async {
    await Supabase.instance.client.auth.signOut();
  }
}
