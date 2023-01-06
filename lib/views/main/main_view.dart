import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:treegram/state/auth/providers/auth_state_provider.dart';
import 'package:treegram/state/image_upload/helpers/image_picker_helper.dart';
import 'package:treegram/state/image_upload/models/file_type.dart';
import 'package:treegram/state/nav_bar/nav_bar_index_provider.dart';
import 'package:treegram/state/post_settings/providers/post_settings_provider.dart';
import 'package:treegram/views/components/dialogs/alert_dialog_model.dart';
import 'package:treegram/views/components/dialogs/logout_dialog.dart';
import 'package:treegram/views/constants/strings.dart';
import 'package:treegram/views/create_new_post/create_new_post_view.dart';
import 'package:treegram/views/tabs/home/home_view.dart';
import 'package:treegram/views/tabs/search/search_view.dart';
import 'package:treegram/views/tabs/users_posts/user_posts_view.dart';

class MainView extends ConsumerStatefulWidget {
  const MainView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainViewState();
}

class _MainViewState extends ConsumerState<MainView> {
  @override
  Widget build(BuildContext context) {
    // Removed - return DefaultTabController(tabs:3),
    final int selectedIndex = ref.watch(navBarIndexProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.appName),
        actions: [
          IconButton(
            icon: const FaIcon(
              FontAwesomeIcons.film,
              size: 20,
            ),
            onPressed: () async {
              final videoFile = await ImagePickerHelper.pickVideoFromGallery();
              if (videoFile == null) {
                return;
              }

              // ref.refresh(postSettingProvider);
              ref.invalidate(postSettingProvider);

              if (!mounted) return;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CreateNewPostView(
                    fileToPost: videoFile,
                    fileType: FileType.video,
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.add_photo_alternate_outlined,
            ),
            onPressed: () async {
              final imageFile = await ImagePickerHelper.pickImageFromGallery();
              if (imageFile == null) {
                return;
              }
              // ref.refresh(postSettingProvider);
              ref.invalidate(postSettingProvider);

              if (!mounted) return;

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CreateNewPostView(
                    fileToPost: imageFile,
                    fileType: FileType.image,
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.logout,
              size: 23,
            ),
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
      // body: const TabBarView(
      //   children: [
      //     UserPostsView(),
      //     UserPostsView(),
      //     UserPostsView(),
      //   ],
      // ),
      body: [
        const HomeView(),
        const SearchView(),
        const UserPostsView(),
      ][selectedIndex],

      // bottomNavigationBar: const TabBar(
      //   padding: EdgeInsets.only(bottom: 10),
      //   indicatorColor: Colors.deepPurpleAccent,
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
      bottomNavigationBar: NavigationBarTheme(
        data: const NavigationBarThemeData(),
        child: NavigationBar(
          height: 60,
          // labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          onDestinationSelected: (int index) {
            ref.read(navBarIndexProvider.notifier).value = index;
          },
          selectedIndex: selectedIndex,

          destinations: const [
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(
                Icons.home_outlined,
              ),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.person),
              icon: Icon(Icons.person_outline),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
