import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:private_gallery/models/cloud_file.dart';

class UserFilesRepository {
  final storedImages = FirebaseFirestore.instance.collection('images');
  final storedVideos = FirebaseFirestore.instance.collection('videos');

  Future uploadImage(CloudFile file) async {
    await storedImages.add(file.toMap());
  }

  Future uploadVideo(CloudFile file) async {
    await storedVideos.add(file.toMap());
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
          (event) =>
              event.docs.map((vids) => CloudFile.fromMap(vids.data())).toList(),
        );
  }
}
