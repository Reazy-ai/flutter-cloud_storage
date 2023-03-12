import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:private_gallery/models/cloud_file.dart';
import 'package:private_gallery/providers/auth_repository_provider.dart';
import 'package:private_gallery/providers/storage_repository_provider.dart';
import 'package:private_gallery/providers/user_files_provider.dart';
import 'package:private_gallery/vm/storage_state.dart';

class UserFilesController extends StateNotifier<StorageState> {
  ImagePicker imagePicker = ImagePicker();
  final Ref _ref;

  UserFilesController({required Ref ref})
      : _ref = ref,
        super(StorageState());

  void uploadPicture() async {
    state = state.copyWith(isLoading: true);
    final selectedImages = await imagePicker.pickMultiImage();
    final userId = _ref.read(currentUserIdProvider);

    try {
      for (var image in selectedImages) {
        final imageName = image.name;
        final imagePath = image.path;

        final imageUrl =
            await _ref.read(storageRepositoryProvider).uploadPicture(
                  picture: File(imagePath),
                  path: '$userId/images/$imageName',
                );
        final imageFile = CloudFile(
          fileName: imageName,
          ownerUserId: userId,
          fileUrl: imageUrl,
          fileType: 'Image',
          createdAt: DateTime.now(),
        );
        await _ref.read(userFilesRepositoryProvider).uploadImage(imageFile);
      }
    } catch (e) {
      rethrow;
    }
    state = state.copyWith(isLoading: false);
  }

  void uploadedVideo() async {
    final userId = _ref.read(currentUserIdProvider);

    state = state.copyWith(isLoading: true);
    final selectedVideo =
        await imagePicker.pickVideo(source: ImageSource.gallery);

    if (selectedVideo != null) {
      final videoName = DateTime.now().millisecondsSinceEpoch.toString();
      final videoPath = selectedVideo.path;

      try {
        final uploadedVideo =
            await _ref.read(storageRepositoryProvider).uploadVideo(
                  video: File(videoPath),
                  path: '$userId/videos/$videoName',
                );

        final videoFile = CloudFile(
          fileName: videoName,
          ownerUserId: userId,
          fileUrl: uploadedVideo,
          fileType: 'Video',
          createdAt: DateTime.now(),
        );
        await _ref.read(userFilesRepositoryProvider).uploadVideo(videoFile);
      } catch (e) {
        rethrow;
      }
    } else {}
    state = state.copyWith(isLoading: false);
  }

  Stream<List<CloudFile>> retrieveImages({required String ownerUserId}) {
    return _ref
        .read(userFilesRepositoryProvider)
        .retrieveImages(ownerUserId: ownerUserId);
  }

  Stream<List<CloudFile>> retrieveVideos({required String ownerUserId}) {
    return _ref
        .read(userFilesRepositoryProvider)
        .retrieveVideos(ownerUserId: ownerUserId);
  }
}
