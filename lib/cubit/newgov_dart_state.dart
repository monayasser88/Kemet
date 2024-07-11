import 'package:kemet/logic/models/newgov.dart';

abstract class UserDataStatenew {}

class UserDataInitialnew extends UserDataStatenew {}

class GovernrateLoading extends UserDataStatenew {}

class GovernrateSuccess extends UserDataStatenew {
  final List<NewGovernrateModel> governorates;

  GovernrateSuccess({required this.governorates});
}

class GovernrateError extends UserDataStatenew {
  final String error;

  GovernrateError({required this.error});
}
