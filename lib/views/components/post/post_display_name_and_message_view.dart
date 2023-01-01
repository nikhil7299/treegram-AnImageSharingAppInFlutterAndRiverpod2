import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:treegram/state/posts/models/post.dart';
import 'package:treegram/state/user_info/providers/user_info_model_provider.dart';
import 'package:treegram/views/components/animations/small_error_animation_view.dart';
import 'package:treegram/views/components/rich_two_parts_text.dart';

class PostDisplayNameAndMessageView extends ConsumerWidget {
  final Post post;
  const PostDisplayNameAndMessageView({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfoModel = ref.watch(
      userInfoModelProvider(
        post.userId,
      ),
    );
    return userInfoModel.when(
      data: (userInfoModel) {
        return Padding(
          padding: const EdgeInsets.all(5),
          child: RichTwoPartsText(
            leftPart: userInfoModel.dispalyName,
            rightPart: post.message,
          ),
        );
      },
      error: (error, stackTrace) {
        return const SmallErrorAnimationView();
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
