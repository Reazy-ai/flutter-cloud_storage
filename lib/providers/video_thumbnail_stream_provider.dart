import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:private_gallery/models/cloud_file.dart';
import 'package:private_gallery/providers/user_files_provider.dart';

final videoStreamProvider =
    StreamProvider.family<List<CloudFile>, String>((ref, ownerUserId) {
  return ref
      .watch(userFilesControllerProvider.notifier)
      .retrieveVideos(ownerUserId: ownerUserId);
});
