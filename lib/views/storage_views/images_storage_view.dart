import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:private_gallery/providers/auth_repository_provider.dart';
import 'package:private_gallery/providers/image_stream_provider.dart';
import 'package:private_gallery/providers/storage_controller_provider.dart';

class ImagesScreen extends ConsumerWidget {
  const ImagesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ownerUserId = ref.watch(currentUserIdProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Images'),
      ),
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          fixedSize: const Size(30, 50),
        ),
        onPressed: () {
          ref
              .read(storageControllerProvider.notifier)
              .uploadImages(ownerUserId: ownerUserId);
        },
        child: const Icon(Icons.add_a_photo_outlined),
      ),
      body: Column(
        children: [
          ref.watch(imageStreamProvider(ownerUserId)).when(
                data: (images) {
                  return images.isNotEmpty
                      ? Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 10,
                              crossAxisCount: 4,
                            ),
                            itemCount: images.length,
                            itemBuilder: (context, index) {
                              final img = images[index];
                              return Image.network(img.fileUrl);
                            },
                          ),
                        )
                      : const Expanded(
                          child: Center(
                            child: Text('You have no Image uploaded'),
                          ),
                        );
                },
                error: (error, stackTrace) {
                  return const Center(
                    child: Text('Error'),
                  );
                },
                loading: () =>
                    const Center(child: CircularProgressIndicator.adaptive()),
              ),
        ],
      ),
    );
  }
}
