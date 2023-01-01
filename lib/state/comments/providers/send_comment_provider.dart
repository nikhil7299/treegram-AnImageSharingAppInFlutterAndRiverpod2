import 'package:hooks_riverpod/hooks_riverpod.dart';
// show StateNotifierProvider;
import 'package:treegram/state/comments/notifiers/send_comment_notifier.dart';
import 'package:treegram/state/image_upload/typedefs/is_loading.dart';

final sendCommentProvider =
    StateNotifierProvider<SendCommentNotifier, IsLoading>(
  (_) => SendCommentNotifier(),
);
