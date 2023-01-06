import 'package:hooks_riverpod/hooks_riverpod.dart';

class NavBarIndexNotifier extends StateNotifier<int> {
  NavBarIndexNotifier() : super(0);
  set value(int index) => state = index;
}
