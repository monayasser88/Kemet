part of 'logout_cubit.dart';

@immutable
sealed class LogoutState {}

final class LogoutInitial extends LogoutState {}
final class LogoutLoading extends LogoutState {}
final class LoggedOutSuccess extends LogoutState {}
final class LogoutFailure extends LogoutState {
  final String errMassage;
  
  LogoutFailure(this.errMassage);
}