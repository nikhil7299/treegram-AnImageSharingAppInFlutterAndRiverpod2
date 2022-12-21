import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:treegram/state/auth/models/auth_state.dart';
import 'package:treegram/state/auth/notifiers/auth_state_notifier.dart';

final authStateProvider = StateNotifierProvider<AuthStateNotifier, AuthState>(
  (_) => AuthStateNotifier(),
);
