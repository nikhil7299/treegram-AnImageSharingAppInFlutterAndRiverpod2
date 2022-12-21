import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:treegram/state/constants/firebase_field_name.dart';
import 'dart:collection' show MapView;

import 'package:treegram/state/posts/typedefs/user_id.dart';

@immutable
class UserInfoPayload extends MapView<String, String> {
  UserInfoPayload({
    required UserId userId,
    required String? displayName,
    required String? email,
  }) : super(
          {
            FirebaseFieldName.userId: userId,
            FirebaseFieldName.displayName: displayName ?? '',
            FirebaseFieldName.email: email ?? '',
          },
        );
}
