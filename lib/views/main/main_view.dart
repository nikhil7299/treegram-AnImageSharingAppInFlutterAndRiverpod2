import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:treegram/state/auth/providers/auth_state_provider.dart';
import 'package:treegram/views/components/dialogs/alert_dialog_model.dart';
import 'package:treegram/views/components/dialogs/logout_dialog.dart';
import 'package:treegram/views/constants/strings.dart';
import 'package:treegram/views/tabs/users_posts/user_posts_view.dart';

class MainView extends ConsumerStatefulWidget {
  const MainView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainViewState();
}

class _MainViewState extends ConsumerState<MainView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(Strings.appName),
          actions: [
            IconButton(
              icon: const FaIcon(FontAwesomeIcons.film),
              onPressed: () async {},
            ),
            IconButton(
              icon: const Icon(Icons.add_photo_alternate_outlined),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                final shouldLogOut = await const LogoutDialog()
                    .present(context)
                    .then((value) => value ?? false);
                if (shouldLogOut) {
                  await ref.read(authStateProvider.notifier).logOut();
                }
              },
            ),
          ],
          // bottom: const TabBar(

          //   tabs: [
          //     Tab(
          //       icon: Icon(Icons.home),
          //     ),
          //     Tab(
          //       icon: Icon(Icons.search),
          //     ),
          //     Tab(
          //       icon: Icon(Icons.person),
          //     ),
          //   ],
          // ),
        ),
        body: const TabBarView(
          children: [
            UserPostsView(),
            UserPostsView(),
            UserPostsView(),
          ],
        ),
        bottomNavigationBar: const TabBar(
          padding: EdgeInsets.only(bottom: 10),
          indicatorColor: Colors.deepPurpleAccent,
          tabs: [
            Tab(
              icon: Icon(Icons.home),
            ),
            Tab(
              icon: Icon(Icons.search),
            ),
            Tab(
              icon: Icon(Icons.person),
            ),
          ],
        ),
      ),
    );
  }
}
