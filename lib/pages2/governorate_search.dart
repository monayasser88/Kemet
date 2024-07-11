import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kemet/cubit2/search_cubit.dart';
import 'package:kemet/views2/governorate_search_view.dart';


class GovernorateSearch extends StatelessWidget {
  const GovernorateSearch({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child:  Scaffold(
        body: GovernorateSearchView(),
      ),
    );
  }
}
