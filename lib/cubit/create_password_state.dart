abstract class createpasswordstate {}

final class createpasswordSuccess extends createpasswordstate {
  final String msg;
  createpasswordSuccess({required this.msg});
}

final class createpasswordInitial extends createpasswordstate {}

class createpasswordLoading extends createpasswordstate {}

class createpasswordError extends createpasswordstate {
  final String error;

  createpasswordError({required this.error});
}
