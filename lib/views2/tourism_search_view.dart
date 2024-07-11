import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kemet/components2/custom_appbar.dart';
import 'package:kemet/components2/search_field.dart';
import 'package:kemet/cubit2/search_cubit.dart';
import 'package:kemet/models2/favorites_tourism.dart';
import 'package:kemet/pages2/history_of_place.dart';
import 'package:kemet/pages2/not_found.dart';

class TourismSearchView extends StatelessWidget {
  TourismSearchView({Key? key}) : super(key: key);
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchState>(
      listener: (context, state) {
        if (state is SearchError) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const NotFound();
          }));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 55,
                ),
                CustomAppBar(
                  title: 'Search',
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                SearchField(
                  label: 'Search',
                  hint: 'search',
                  controller: _searchController,
                  onPressed: () {
                    if (_searchController.text.isNotEmpty) {
                      context
                          .read<SearchCubit>()
                          .tourismSearch(_searchController.text);
                    }
                  },
                  onChanged: (value) {
                    if (value.isEmpty) {
                      context.read<SearchCubit>().clearSearchResults();
                    } else {
                      context.read<SearchCubit>().tourismSearch(value);
                    }
                  },
                ),
                if (state is SearchLoading)
                  const Center(child: CircularProgressIndicator())
                else if (state is SearchLoaded)
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.results.length,
                      itemBuilder: (context, index) {
                        final result = state.results[index];
                        //final id = result['_id'];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              result['imgCover'],
                            ),
                          ),
                          title: Text(result['name']),
                          trailing: IconButton(
                            icon: const Icon(Icons.arrow_forward),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HistoryOfPlace(
                                    tourismPlace:
                                          TourismPlace.fromJson(result),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


