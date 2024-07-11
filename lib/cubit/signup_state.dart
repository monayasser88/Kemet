abstract class SignEmailState {}

final class SignEmailSuccess extends SignEmailState {
  final String msg;
  SignEmailSuccess({required this.msg});
}

final class SignEmailInitial extends SignEmailState {}

class SignEmailLoading extends SignEmailState {}

class SignEmailError extends SignEmailState {
  final String error;

  SignEmailError({required this.error});
}
