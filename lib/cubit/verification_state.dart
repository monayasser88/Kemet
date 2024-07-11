abstract class verificationEmailstate {}

final class verificationEmailSuccess extends verificationEmailstate {
  final String msg;
  verificationEmailSuccess({required this.msg});
}

final class verificationEmailInitial extends verificationEmailstate {}

class verificationEmailLoading extends verificationEmailstate {}

class verificationEmaillError extends verificationEmailstate {
  final String error;

  verificationEmaillError({required this.error});
}
