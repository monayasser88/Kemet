
part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final Profile profile;

  ProfileLoaded(this.profile);
}
class FirstNameUpdated extends ProfileState {
    final Profile profile;

  FirstNameUpdated(this.profile);
}
class PhotoUpdated extends ProfileState {
    final Profile profile;

  PhotoUpdated(this.profile);
}

final class ProfileError extends ProfileState {
  final String errMassage;

  ProfileError(this.errMassage);
}
class UploadPicture extends ProfileState {
}
