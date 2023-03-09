import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:private_gallery/providers/auth_repository_provider.dart';
import 'package:private_gallery/providers/storage_controller_provider.dart';

class VideosScreen extends ConsumerWidget {
  const VideosScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ownerUserId = ref.watch(currentUserIdProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Videos'),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          ref
              .read(storageControllerProvider.notifier)
              .uploadVideo(ownerUserId: ownerUserId);
        },
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          fixedSize: const Size(30, 50),
        ),
        child: const Icon(Icons.videocam_outlined),
      ),
    );
  }
}
