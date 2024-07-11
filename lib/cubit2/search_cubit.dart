import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:kemet/services2/search_repository.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepository _repository = SearchRepository();

  SearchCubit() : super(SearchInitial());

  Future<void> tourismSearch(String keyword) async {
    if (keyword.isEmpty) {
      emit(SearchError("Please enter a keyword to search."));
      return;
    }
    try {
      emit(SearchLoading());
      final List<Map<String, dynamic>> results =
          await _repository.tourismSearch(keyword);
      if (results.isNotEmpty) {
        emit(SearchLoaded(results));
      } else {
        emit(SearchError("No results found for '$keyword'."));
      }
    } catch (e) {
      emit(SearchError("Error occurred while searching."));
    }
  }

  Future<void> governorateSearch(String keyword) async {
    if (keyword.isEmpty) {
      emit(SearchError("Please enter a keyword to search."));
      return;
    }
    try {
      emit(SearchLoading());
      final List<Map<String, dynamic>> results =
          await _repository.governorateSearch(keyword);
      if (results.isNotEmpty) {
        emit(SearchLoaded(results));
      } else {
        emit(SearchError("No results found for '$keyword'."));
      }
    } catch (e) {
      emit(SearchError("Error occurred while searching."));
    }
  }

  Future<void> legendSearch(String keyword) async {
    if (keyword.isEmpty) {
      emit(SearchError("Please enter a keyword to search."));
      return;
    }
    try {
      emit(SearchLoading());
      final List<Map<String, dynamic>> results =
          await _repository.legendSearch(keyword);
      if (results.isNotEmpty) {
        emit(SearchLoaded(results));
      } else {
        emit(SearchError("No results found for '$keyword'."));
      }
    } catch (e) {
      emit(SearchError("Error occurred while searching."));
    }
  }

  void clearSearchResults() {
    emit(ClearedSearchState());
  }
}
