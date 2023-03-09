import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:private_gallery/views/storage_views/images_storage_view.dart';
import 'package:private_gallery/views/storage_views/videos_storage_view.dart';
import 'package:private_gallery/vm/login_controller.dart';

class StorageScreen extends ConsumerWidget {
  const StorageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cloud Storage'),
        actions: [
          PopupMenuButton(
            itemBuilder: (ctx) {
              return [
                PopupMenuItem(
                    child: const Text('Logout'),
                    onTap: () {
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        ref
                            .read(loginControllerProvider.notifier)
                            .logOut(context);
                      });
                    }),
              ];
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Images'),
            trailing: const Icon(Icons.arrow_forward_ios),
            style: ListTileStyle.drawer,
            onTap: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const ImagesScreen(),
                ),
                (route) => true),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.video_library),
            title: const Text('Videos'),
            trailing: const Icon(Icons.arrow_forward_ios),
            style: ListTileStyle.drawer,
            onTap: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const VideosScreen(),
                ),
                (route) => true),
          ),
        ],
      ),
    );
  }
}
