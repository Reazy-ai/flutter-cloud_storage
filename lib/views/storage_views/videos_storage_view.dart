import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:private_gallery/providers/user_files_provider.dart';

class VideosScreen extends ConsumerWidget {
  const VideosScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Videos'),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          ref.read(userFilesControllerProvider.notifier).uploadedVideo();
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
