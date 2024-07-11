abstract class ResetPasswordstate {}

final class ResetPasswordSuccess extends ResetPasswordstate {
  final String msg;
  ResetPasswordSuccess({required this.msg});
}

final class ResetPasswordInitial extends ResetPasswordstate {}

class ResetPasswordLoading extends ResetPasswordstate {}

class ResetPasswordError extends ResetPasswordstate {
  final String error;

  ResetPasswordError({required this.error});
}
