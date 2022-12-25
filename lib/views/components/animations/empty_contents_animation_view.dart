import 'package:treegram/views/components/animations/lottie_animation_view.dart';
import 'package:treegram/views/components/animations/models/lottie_animation.dart';

class EmptyContentAnimationView extends LottieAnimationView {
  const EmptyContentAnimationView({super.key})
      : super(
          animation: LottieAnimation.empty,
        );
}
