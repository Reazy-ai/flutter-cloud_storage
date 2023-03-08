import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  const LoginState();
  @override
  List<Object?> get props => [];
}

class LoginStateInitial extends LoginState {
  const LoginStateInitial();
  @override
  List<Object?> get props => [];
}

class LoginStateLoading extends LoginState {
  const LoginStateLoading();
  @override
  List<Object?> get props => [];
}

class LoginStateSuccess extends LoginState {
  const LoginStateSuccess();
  @override
  List<Object?> get props => [];
}

class LoginStateNeedsVerification extends LoginState {
  const LoginStateNeedsVerification();
  @override
  List<Object?> get props => [];
}

class LoginStateFailure extends LoginState {
  final String errorCode;
  const LoginStateFailure(this.errorCode);
  @override
  List<Object?> get props => [errorCode];
}
