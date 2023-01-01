import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:treegram/state/auth/providers/user_id_provider.dart';
import 'package:treegram/state/comments/models/comment.dart';
import 'package:treegram/state/comments/providers/delete_comment_provider.dart';
import 'package:treegram/state/user_info/providers/user_info_model_provider.dart';
import 'package:treegram/views/components/animations/small_error_animation_view.dart';
import 'package:treegram/views/components/constants/strings.dart';
import 'package:treegram/views/components/dialogs/alert_dialog_model.dart';
import 'package:treegram/views/components/dialogs/delete_dialog.dart';
// show ConsumerWidget, WidgetRef;

class CommentTile extends ConsumerWidget {
  final Comment comment;
  const CommentTile({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(
      userInfoModelProvider(
        comment.fromUserId,
      ),
    );
    return userInfo.when(
      data: (userInfo) {
        final currentUserId = ref.read(userIdProvider);
        return ListTile(
          trailing: currentUserId == comment.fromUserId
              ? IconButton(
                  onPressed: () async {
                    final showDeleteComment =
                        await displayDeleteDialog(context);
                    if (showDeleteComment) {
                      await ref
                          .read(deleteCommentProvider.notifier)
                          .deleteComment(commentId: comment.id);
                    }
                  },
                  icon: const Icon(Icons.delete_forever_rounded),
                )
              : null,
          title: Text(
            userInfo.dispalyName,
          ),
          subtitle: Text(
            comment.comment,
          ),
        );
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
      error: (error, stackTrace) => const SmallErrorAnimationView(),
    );
  }

  Future<bool> displayDeleteDialog(BuildContext context) =>
      const DeleteDialog(titleOfObjectToDelete: Strings.comment)
          .present(context)
          .then(
            (value) => value ?? false,
          );
}
