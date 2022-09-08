import 'package:core/presentation/bloc/series/popular_series/popular_series_bloc.dart';
import 'package:core/presentation/widgets/series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-series';

  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularSeriesPage> {
  @override
  void initState() {
    super.initState();
    context.read<PopularSeriesBloc>().add(FetchPopularSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularSeriesBloc, PopularSeriesState>(
          builder: (context, state) {
            if (state is PopularSeriesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularSeriesError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.error),
              );
            } else if (state is PopularSeriesHasData) {
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
