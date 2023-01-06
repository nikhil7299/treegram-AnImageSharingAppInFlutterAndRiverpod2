import 'package:collection/collection.dart' show IterableEquality;
import 'package:flutter/foundation.dart' show immutable;

import 'package:treegram/state/comments/models/comment.dart';
import 'package:treegram/state/posts/models/post.dart';

@immutable
class PostWithComments {
  final Post post;
  final Iterable<Comment> comments;

  const PostWithComments({
    required this.post,
    required this.comments,
  });

  @override
  bool operator ==(covariant PostWithComments other) =>
      post == other.post &&
      const IterableEquality().equals(
        comments,
        other.comments,
      );

  @override
  int get hashCode => Object.hashAll(
        [
          post,
          comments,
        ],
      );
}
