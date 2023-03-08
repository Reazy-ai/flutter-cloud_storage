import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:private_gallery/auth_checker.dart';
import 'package:private_gallery/providers/auth_provider.dart';
import 'package:private_gallery/vm/login_controller.dart';
import 'package:private_gallery/vm/storage_controller.dart';

class StorageScreen extends ConsumerStatefulWidget {
  const StorageScreen({super.key});

  @override
  ConsumerState<StorageScreen> createState() => _StorageScreenState();
}

class _StorageScreenState extends ConsumerState<StorageScreen> {
  @override
  Widget build(BuildContext context) {
    final ownerUserId = ref.watch(currentUserIdProvider);
    return Scaffold(
      appBar: AppBar(
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
        children: [
          Center(
            child: TextButton(
              onPressed: () {
                ref
                    .read(storageControllerProvider.notifier)
                    .uploadImages(ownerUserId: ownerUserId);
              },
              child: const Text('Pick image'),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: TextButton(
              onPressed: () {
                ref
                    .read(storageControllerProvider.notifier)
                    .uploadVideo(ownerUserId: ownerUserId);
              },
              child: const Text('Pick video'),
            ),
          ),
          const SizedBox(height: 30),
          ref.watch(imagesProvider(ownerUserId)).when(
                data: (images) {
                  return Expanded(
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
                  );
                },
                error: (error, stackTrace) {
                  debugPrintStack(
                      stackTrace: stackTrace, label: error.toString());
                  return const Center(
                    child: Text('Error'),
                  );
                },
                loading: () => const CircularProgressIndicator.adaptive(),
              ),
        ],
      ),
    );
  }
}

// The grid view

