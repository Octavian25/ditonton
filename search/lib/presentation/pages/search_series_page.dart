import 'package:core/presentation/widgets/series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/core.dart';
import 'package:search/search.dart';

class SearchSeriesPage extends StatelessWidget {
  const SearchSeriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (query) {
                context
                    .read<SearchSeriesBloc>()
                    .add(OnQuerySeriesChanged(query));
              },
              decoration: const InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            BlocBuilder<SearchSeriesBloc, SearchSeriesState>(
              builder: (context, state) {
                if (state is SearchSeriesLoading) {
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
                } else if (state is SearchSeriesHasData) {
                  final result = state.result;
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final series = result[index];
                        return SeriesCard(series);
                      },
                      itemCount: result.length,
                    ),
                  );
                } else if (state is SearchSeriesError) {
                  return Expanded(
                    child: Center(
                      child: Text(state.error),
                    ),
                  );
                } else {
                  return const Expanded(
                    child: SizedBox(),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
