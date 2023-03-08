import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final bool isLoading;
  const LoginState({required this.isLoading});
  @override
  List<Object?> get props => [isLoading];
}

class LoginStateInitial extends LoginState {
  const LoginStateInitial() : super(isLoading: false);
  @override
  List<Object?> get props => [];
}

class LoginStateLoading extends LoginState {
  const LoginStateLoading() : super(isLoading: true);
  @override
  List<Object?> get props => [];
}

class LoginStateSuccess extends LoginState {
  const LoginStateSuccess() : super(isLoading: false);
  @override
  List<Object?> get props => [];
}

class LoginStateFailure extends LoginState {
  final String errorCode;
  const LoginStateFailure(this.errorCode) : super(isLoading: false);
  @override
  List<Object?> get props => [errorCode];
}
