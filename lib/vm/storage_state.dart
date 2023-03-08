import 'package:equatable/equatable.dart';

class StorageState extends Equatable {
  bool isLoading;
  StorageState({
    required this.isLoading,
  });
  @override
  List<Object?> get props => [];
}
