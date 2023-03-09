import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:private_gallery/models/cloud_file.dart';
import 'package:private_gallery/providers/storage_repository_provider.dart';
import 'package:private_gallery/vm/storage_state.dart';

class StorageController extends StateNotifier<StorageState> {
  final Ref ref;
  StorageController(this.ref) : super(StorageState());

  void uploadImages({required String ownerUserId}) async {
    try {
      state = StorageState(isLoading: true);
      await ref
          .read(storageRepositoryProvider)
          .uploadImages(ownerUserId: ownerUserId);
    } catch (e) {
      rethrow;
    }
    state = StorageState(isLoading: false);
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

  Stream<List<CloudFile>> retrieveVideos({required String ownerUserId}) {
    return ref
        .read(storageRepositoryProvider)
        .retrieveVideos(ownerUserId: ownerUserId);
  }

  void deleteImage({
    required String ownerUserId,
    required String imageName,
  }) async {}
}
