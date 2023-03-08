import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:private_gallery/models/cloud_file.dart';
import 'package:private_gallery/providers/storage_provider.dart';
import 'package:private_gallery/vm/storage_state.dart';

final storageControllerProvider =
    StateNotifierProvider<StorageController, StorageState>(
  (ref) => StorageController(ref),
);

final imagesProvider =
    StreamProvider.family<List<CloudFile>, String>((ref, ownerUserId) {
  return ref
      .watch(storageControllerProvider.notifier)
      .retrieveImages(ownerUserId: ownerUserId);
});

class StorageController extends StateNotifier<StorageState> {
  final Ref ref;
  StorageController(this.ref) : super(StorageState(isLoading: false));

  void uploadImages({required String ownerUserId}) async {
    try {
      await ref
          .read(storageRepositoryProvider)
          .uploadImages(ownerUserId: ownerUserId);
    } catch (e) {
      rethrow;
    }
  }

  void uploadVideo({required String ownerUserId}) async {
    try {
      await ref
          .read(storageRepositoryProvider)
          .uploadVideo(ownerUserId: ownerUserId);
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<CloudFile>> retrieveImages({required String ownerUserId}) {
    return ref
        .read(storageRepositoryProvider)
        .retrieveImages(ownerUserId: ownerUserId);
  }

  Stream<CloudFile> retrieveVideos({required String ownerUserId}) {
    return ref
        .read(storageRepositoryProvider)
        .retrieveVideos(ownerUserId: ownerUserId);
  }

  void deleteImage({
    required String ownerUserId,
    required String imageName,
  }) async {}
}
