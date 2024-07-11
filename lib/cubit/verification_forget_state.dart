abstract class ForgetVerificationstate {}

final class ForgetVerificationSuccess extends ForgetVerificationstate {
  final String msg;
  ForgetVerificationSuccess({required this.msg});
}

final class ForgetVerificationInitial extends ForgetVerificationstate {}

class ForgetVerificationLoading extends ForgetVerificationstate {}

class ForgetVerificationError extends ForgetVerificationstate {
  final String error;

  ForgetVerificationError({required this.error});
}
