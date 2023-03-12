import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:private_gallery/providers/auth_repository_provider.dart';
import 'package:private_gallery/providers/user_files_provider.dart';
import 'package:private_gallery/providers/video_thumbnail_stream_provider.dart';

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
          ref.read(userFilesControllerProvider.notifier).uploadedVideo();
        },
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          fixedSize: const Size(30, 50),
        ),
        child: const Icon(Icons.videocam_outlined),
      ),
      body: Column(
        children: [
          ref.watch(videoStreamProvider(ownerUserId)).when(
                data: (videos) {
                  return videos.isNotEmpty
                      ? Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 10,
                              crossAxisCount: 4,
                            ),
                            itemCount: videos.length,
                            itemBuilder: (context, index) {
                              final vid = videos[index];
                              return Image.network(vid.fileUrl);
                            },
                          ),
                        )
                      : const Expanded(
                          child: Center(
                            child: Text('You have no video uploaded'),
                          ),
                        );
                },
                error: (error, stackTrace) {
                  debugPrint(error.toString());
                  debugPrint(stackTrace.toString());
                  return const Center(
                    child: Text('Unable to fetch videos from server'),
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
        ],
      ),
    );
  }
}
