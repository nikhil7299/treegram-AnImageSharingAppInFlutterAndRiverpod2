import 'package:flutter/foundation.dart' show immutable, VoidCallback;
import 'package:treegram/views/components/rich_text/base_text.dart';

@immutable
class LinkText extends BaseText {
  final VoidCallback onTapped;
  const LinkText({
    required super.text,
    super.style,
    required this.onTapped,
  });
}
