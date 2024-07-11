abstract class SignInstate {}

final class SignInSuccess extends SignInstate {
  final String msg;
    final String token;

  SignInSuccess({required this.msg, required this.token});
}

final class SignInInitial extends SignInstate {}

class SignInLoading extends SignInstate {}

class SignInError extends SignInstate {
  final String error;

  SignInError({required this.error});
}
