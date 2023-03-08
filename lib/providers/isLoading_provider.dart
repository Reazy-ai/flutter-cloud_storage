import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:private_gallery/vm/login_controller.dart';
import 'package:private_gallery/vm/login_state.dart';

final isLoadingProvider = Provider<LoginState>((ref) {
  final isLoading = ref.watch(loginControllerProvider);
  return isLoading;
});
