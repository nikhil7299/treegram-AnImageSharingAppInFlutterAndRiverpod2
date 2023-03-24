import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:treegram/state/auth/providers/auth_state_provider.dart';
import 'package:treegram/state/image_upload/helpers/image_picker_helper.dart';
import 'package:treegram/state/image_upload/models/file_type.dart';
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

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(Strings.appName),
          actions: [
            IconButton(
              icon: const FaIcon(
                FontAwesomeIcons.film,
                size: 20,
              ),
              onPressed: () async {
                final videoFile =
                    await ImagePickerHelper.pickVideoFromGallery();
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
                final imageFile =
                    await ImagePickerHelper.pickImageFromGallery();
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
          bottom: TabBar(
            splashBorderRadius: BorderRadius.circular(60),
            splashFactory: NoSplash.splashFactory,
            indicatorPadding: const EdgeInsets.symmetric(vertical: 6),
            labelColor: Colors.white,
            dividerColor: Colors.transparent,
            indicatorColor: Colors.transparent,
            indicator: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(60),
            ),
            unselectedLabelColor: Colors.white38,
            tabs: [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.home,
                      size: 20,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "Home",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.search,
                      size: 20,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "Search",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
              Tab(
                icon: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.person,
                      size: 20,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "Profile",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            HomeView(),
            SearchView(),
            UserPostsView(),
          ],
        ),
      ),
    );
  }
}
