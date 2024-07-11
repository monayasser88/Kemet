import 'package:bloc/bloc.dart';
import 'package:kemet/models2/favorites_tourism.dart';
import 'package:kemet/repositories/governrate_repo.dart';



class GovernatesCubit extends Cubit<List<Governate>> {
  final GovernatesRepository governatesRepository;

  GovernatesCubit({required this.governatesRepository}) : super([]);

  void fetchGovernates() async {
    try {
      List<Governate> governates = await governatesRepository.fetchGovernates();
      emit(governates);
    } catch (e) {
      emit([]); // Emit an empty list in case of error
      // Handle error, e.g., show error message
    }
  }
}

