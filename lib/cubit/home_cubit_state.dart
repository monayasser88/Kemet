import 'package:kemet/logic/models/Homepage.dart';
import 'package:kemet/logic/models/governratemodel.dart';
import 'package:kemet/logic/models/offerModel.dart';

abstract class UserDataState {}

class UserDataInitial extends UserDataState {}

class UserDataSuccess extends UserDataState {
  final UserModel user;

  UserDataSuccess(this.user);
}

class UserDataError extends UserDataState {
   final String error;

  UserDataError({required this.error});
}
class UserDataLoading extends UserDataState {}





class governrateSuccess extends UserDataState {
  final governrateModel alexandria;
  final governrateModel cairo;
  final governrateModel aswan;
  final governrateModel luxor;
  final governrateModel mersaMatruh;

  governrateSuccess({
    required this.alexandria,
    required this.cairo,
    required this.aswan,
    required this.luxor,
    required this.mersaMatruh,
  });

  List<Object?> get props => [alexandria, cairo, aswan, luxor, mersaMatruh];
}


class governrateError extends UserDataState {
   final String error;

  governrateError({required this.error});
}
class governrateLoading extends UserDataState {}


class offerSuccess extends UserDataState {
 final OfferModel oneId;
 final OfferModel twoId;

  //final governrateModel mersaMatruh;

  offerSuccess({
    required this.oneId,
    required this.twoId,
   
    
  });

  List<Object?> get props => [oneId, twoId];
}

class offerError extends UserDataState {
   final String error;

  offerError({required this.error});
}
class offerLoading extends UserDataState {}