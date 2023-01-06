import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:treegram/state/constants/firebase_collection_name.dart';
import 'package:treegram/state/constants/firebase_field_name.dart';
import 'package:treegram/state/likes/models/like.dart';
import 'package:treegram/state/likes/models/like_dislike_request.dart';

final likeDislikePostProvider = FutureProvider.family
    .autoDispose<bool, LikeDislikeRequest>(
        (ref, LikeDislikeRequest request) async {
  final query = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.likes)
      .where(
        FirebaseFieldName.postId,
        isEqualTo: request.postId,
      )
      .where(
        FirebaseFieldName.userId,
        isEqualTo: request.likedBy,
      )
      .get();

  final hasLiked = await query.then(
    (snapshot) => snapshot.docs.isNotEmpty,
  );
  if (hasLiked) {
    //delete like object
    try {
      await query.then((snapshot) async {
        for (final doc in snapshot.docs) {
          await doc.reference.delete();
        }
      });

      return true;
    } catch (_) {
      return false;
    }
  } else {
    //create like object

    final like = Like(
      postId: request.postId,
      likedBy: request.likedBy,
      // date: DateTime.now(),
      // date: '${FieldValue.serverTimestamp()}',
    );
    try {
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.likes)
          .add(like);
      return true;
    } catch (_) {
      return false;
    }
  }
});
