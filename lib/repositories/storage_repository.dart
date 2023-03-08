import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:private_gallery/models/cloud_file.dart';

class StorageRepository {
  final storage = FirebaseStorage.instance.ref();
  final storedImages = FirebaseFirestore.instance.collection('images');
  final storedVideos = FirebaseFirestore.instance.collection('videos');
  ImagePicker imagePicker = ImagePicker();

  Future uploadImages({required String ownerUserId}) async {
    final selectedImages = await imagePicker.pickMultiImage();
    try {
      for (var image in selectedImages) {
        final imagePath = image.path;
        final imageName = image.name;

        final uploadedImage = await storage
            .child('$ownerUserId/images/$imageName')
            .putFile(File(imagePath));
        final imageUrl = await uploadedImage.ref.getDownloadURL();

        await storedImages.add(CloudFile(
          fileName: imageName,
          ownerUserId: ownerUserId,
          fileUrl: imageUrl,
          fileType: 'image',
        ).toMap());
      }
    } catch (e) {
      rethrow;
    }
  }

  Future uploadVideo({required String ownerUserId}) async {
    final selectedVideo =
        await imagePicker.pickVideo(source: ImageSource.gallery);

    if (selectedVideo != null) {
      final videoName = DateTime.now().millisecondsSinceEpoch.toString();
      final videoPath = selectedVideo.path;

      try {
        final uploadedVideo = await storage
            .child('$ownerUserId/videos/$videoName')
            .putFile(File(videoPath));
        final videoUrl = await uploadedVideo.ref.getDownloadURL();

        await storedVideos.add(CloudFile(
          fileName: videoName,
          ownerUserId: ownerUserId,
          fileUrl: videoUrl,
          fileType: 'video',
        ).toMap());
      } catch (e) {
        rethrow;
      }
    } else {}
  }

// Stream of User images.
  Stream<List<CloudFile>> retrieveImages({required String ownerUserId}) {
    return storedImages
        .where('ownerUserId', isEqualTo: ownerUserId)
        .snapshots()
        .map(
          (event) =>
              event.docs.map((img) => CloudFile.fromMap(img.data())).toList(),
        );
  }

// Stream of User videos.
  Stream<List<CloudFile>> retrieveVideos({required String ownerUserId}) {
    return storedVideos
        .where('ownerUserId', isEqualTo: ownerUserId)
        .snapshots()
        .map(
          (event) => event.docs
              .map((vids) => CloudFile.fromMap(vids as Map<String, dynamic>))
              .toList(),
        );
  }
}

Future downloadImageTodevice({required String ownerUserId}) async {}

Future downloadVideoTodevice({required String ownerUserId}) async {}

Future deleteImage({
  required String ownerUserId,
  required String imageName,
}) async {}

Future deleteVideo({
  required String ownerUserId,
  required String videoName,
}) async {}
