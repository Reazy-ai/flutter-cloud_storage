import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:private_gallery/repositories/user_files_repository.dart';
import 'package:private_gallery/vm/storage_state.dart';
import 'package:private_gallery/vm/user_files_controller.dart';

final userFilesRepositoryProvider = Provider<UserFilesRepository>((ref) {
  return UserFilesRepository();
});

final userFilesControllerProvider =
    StateNotifierProvider<UserFilesController, StorageState>((ref) {
  return UserFilesController(ref: ref);
});
