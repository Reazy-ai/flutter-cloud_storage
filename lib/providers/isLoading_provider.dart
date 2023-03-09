import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:private_gallery/providers/storage_controller_provider.dart';
import 'package:private_gallery/vm/login_controller.dart';
import 'package:private_gallery/vm/login_state.dart';

final isLoadingProvider = Provider<bool>((ref) {
  final authStateLoading = ref.watch(loginControllerProvider);
  final storageStateLoading = ref.watch(storageControllerProvider);
  return authStateLoading is LoginStateLoading || storageStateLoading.isLoading;
});
