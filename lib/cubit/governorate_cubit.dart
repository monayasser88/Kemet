import 'package:bloc/bloc.dart';

import 'governorate_state.dart';

// Define the cubit for the Governates screen
class GovernatesCubit extends Cubit<GovernatesState> {
  final GovernatesRepository governatesRepository;

  GovernatesCubit(this.governatesRepository) : super(GovernatesInitialState());

  // Function to fetch governates data
  void fetchGovernates() async {
    emit(GovernatesLoadingState());

    try {
      // Call the API through the repository
      List<String> governates = await governatesRepository.fetchGovernates();

      emit(GovernatesLoadedState(governates));
    } catch (e) {
      emit(GovernatesErrorState('Failed to fetch governates: $e'));
    }
  }
}

// Repository class to handle API calls
class GovernatesRepository {
  final String baseUrl;

  GovernatesRepository({required this.baseUrl});

  // Function to fetch governates data from the API
  Future<List<String>> fetchGovernates() async {
    // Make API call to fetch governates data
    // Example:
    // final response = await http.get('$baseUrl/governates');
    // if (response.statusCode == 200) {
    //   final List<String> governates = json.decode(response.body);
    //   return governates;
    // } else {
    //   throw Exception('Failed to load governates');
    // }

    // Mock data until you integrate with a real API
    return List<String>.generate(27, (index) => 'Governate $index');
  }
}



