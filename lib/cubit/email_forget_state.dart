abstract class EmailForgetstate {}

final class EmailForgetSuccess extends EmailForgetstate {
  final String msg;
  EmailForgetSuccess({required this.msg});
}

final class EmailForgetInitial extends EmailForgetstate {}

class EmailForgetLoading extends EmailForgetstate {}

class EmailForgetError extends EmailForgetstate {
  final String error;

  EmailForgetError({required this.error});
}
