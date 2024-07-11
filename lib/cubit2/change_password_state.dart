part of 'change_password_cubit.dart';

@immutable
sealed class ChangePasswordState {}

final class ChangePasswordInitial extends ChangePasswordState {}
final class ChangePasswordLoading extends ChangePasswordState {}
final class ChangePasswordSuccess extends ChangePasswordState {}
final class ChangePasswordFailure extends ChangePasswordState {
  final String errMassage;
  
  ChangePasswordFailure(this.errMassage);
}
final class ChangePasswordFailure2 extends ChangePasswordState {
  final String errMassage;
  
  ChangePasswordFailure2(this.errMassage);
}

