

// Define the states for the Governates screen
abstract class GovernatesState {}

class GovernatesInitialState extends GovernatesState {}

class GovernatesLoadingState extends GovernatesState {}

class GovernatesLoadedState extends GovernatesState {
  final List<String> governates;

  GovernatesLoadedState(this.governates);
}

class GovernatesErrorState extends GovernatesState {
  final String errorMessage;

  GovernatesErrorState(this.errorMessage);
}

