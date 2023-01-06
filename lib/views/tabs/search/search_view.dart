import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:treegram/views/components/search_grid_view.dart';
import 'package:treegram/views/constants/strings.dart';
import 'package:treegram/views/extensions/dismiss_keyboard.dart';

class SearchView extends HookConsumerWidget {
  const SearchView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    final searchTerm = useState('');

    useEffect(
      () {
        controller.addListener(() {
          searchTerm.value = controller.text;
        });
        return () {};
      },
      [controller],
    );
//sliver to box adpter alternative
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
          child: TextField(
            controller: controller,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              labelText: Strings.enterYourSearchTermHere,
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  controller.clear();
                  dismissKeyboard();
                },
              ),
            ),
          ),
        ),
        Expanded(
          child: SearchGridView(
            searchTerm: searchTerm.value,
          ),
        ),
      ],
    );

    //       child: Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: TextField(
    //           controller: controller,
    //           textInputAction: TextInputAction.search,
    //           decoration: InputDecoration(
    //             labelText: Strings.enterYourSearchTermHere,
    //             suffixIcon: IconButton(
    //               icon: const Icon(Icons.clear),
    //               onPressed: () {
    //                 controller.clear();
    //                 dismissKeyboard();
    //               },
    //             ),
    //           ),
    //         ),
    //       ),
    //     ),
    //     SearchGridView(
    //       searchTerm: searchTerm.value,
    //     ),
    //   ],
    // );
  }
}
