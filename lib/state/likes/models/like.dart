import 'dart:collection' show MapView;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:treegram/state/constants/firebase_field_name.dart';
import 'package:treegram/state/posts/typedefs/post_id.dart';
import 'package:treegram/state/posts/typedefs/user_id.dart';

@immutable
class Like extends MapView<String, dynamic> {
  Like({
    required PostId postId,
    required UserId likedBy,
    // required String date,
  }) : super(
          {
            FirebaseFieldName.postId: postId,
            FirebaseFieldName.userId: likedBy,

            // FirebaseFieldName.date: date.toIso8601String(),
            FirebaseFieldName.createdAt: FieldValue.serverTimestamp(),
            // FirebaseFieldName.date: FieldValue.serverTimestamp().toString(),
          },
        );
}
