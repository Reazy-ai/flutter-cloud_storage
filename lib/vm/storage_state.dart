import 'package:equatable/equatable.dart';

class StorageState extends Equatable {
  bool isLoading;
  StorageState({
    this.isLoading = false,
  });
  @override
  List<Object?> get props => [];

  StorageState copyWith({
    bool? isLoading,
  }) {
    return StorageState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
