import 'dart:collection' show MapView;

import 'package:flutter/foundation.dart' show immutable;
import 'package:treegram/state/constants/firebase_field_name.dart';
import 'package:treegram/state/posts/typedefs/user_id.dart';

@immutable
class UserInfoModel extends MapView<String, String?> {
  final UserId userId;
  final String dispalyName;
  final String? email;

  UserInfoModel({
    required this.userId,
    required this.dispalyName,
    required this.email,
  }) : super(
          {
            FirebaseFieldName.userId: userId,
            FirebaseFieldName.displayName: dispalyName,
            FirebaseFieldName.email: email,
          },
        );
  UserInfoModel.fromJson(
    Map<String, dynamic> json, {
    required UserId userId,
  }) : this(
          userId: userId,
          dispalyName: json[FirebaseFieldName.displayName] ?? '',
          email: json[FirebaseFieldName.email],
        );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserInfoModel &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          dispalyName == other.dispalyName &&
          email == other.email;

  @override
  int get hashCode => Object.hashAll(
        [
          userId,
          dispalyName,
          email,
        ],
      );
}
