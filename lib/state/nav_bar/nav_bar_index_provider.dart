import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:treegram/state/nav_bar/nav_bar_index_notifier.dart';

final navBarIndexProvider = StateNotifierProvider<NavBarIndexNotifier, int>(
  (_) => NavBarIndexNotifier(),
);
