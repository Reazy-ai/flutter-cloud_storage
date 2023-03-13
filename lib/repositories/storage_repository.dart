import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageRepository {
  final storage = FirebaseStorage.instance.ref();

  Future<String> uploadPicture(
      {required File picture, required String path}) async {
    final uploadedImage = await storage.child(path).putFile(picture);
    final imageUrl = await uploadedImage.ref.getDownloadURL();
    return imageUrl;
  }

  Future<String> uploadVideo(
      {required File video, required String path}) async {
    final uploadedVideo = await storage.child(path).putFile(video);
    final videoUrl = await uploadedVideo.ref.getDownloadURL();
    return videoUrl;
  }

  void deleteImage({required String path}) async {
    await storage.child(path).delete();
  }
}
