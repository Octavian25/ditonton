import 'package:core/presentation/bloc/series/top_rated_series/top_rated_series_bloc.dart';
import 'package:core/presentation/widgets/series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-series';

  @override
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedSeriesPage> {
  @override
  void initState() {
    super.initState();
    context.read<TopRatedSeriesBloc>().add(FetchTopRatedSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedSeriesBloc, TopRatedSeriesState>(
          builder: (context, state) {
            if (state is TopRatedSeriesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedSeriesError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.error),
              );
            } else if (state is TopRatedSeriesHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final series = state.result[index];
                  return SeriesCard(series);
                },
                itemCount: state.result.length,
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
