import 'package:flutter/foundation.dart';

typedef CloseLoadingOverlay = bool Function();
typedef UpdateLoadingOverlay = bool Function();

@immutable
class LoadingOverlayController {
  final CloseLoadingOverlay close;
  final UpdateLoadingOverlay update;
  const LoadingOverlayController({
    required this.close,
    required this.update,
  });
}
