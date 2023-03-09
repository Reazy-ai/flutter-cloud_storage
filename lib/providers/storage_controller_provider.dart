import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:private_gallery/vm/storage_controller.dart';
import 'package:private_gallery/vm/storage_state.dart';

final storageControllerProvider =
    StateNotifierProvider<StorageController, StorageState>(
  (ref) => StorageController(ref),
);
