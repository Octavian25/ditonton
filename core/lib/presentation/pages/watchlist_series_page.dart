import 'package:core/core.dart';
import 'package:core/presentation/bloc/series/watchlist_series/watchlist_series_bloc.dart';
import 'package:core/presentation/widgets/series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-series';

  const WatchlistSeriesPage({Key? key}) : super(key: key);

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistSeriesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    context.read<WatchlistSeriesBloc>().add(FetchWatchlistSeries());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistSeriesBloc>().add(FetchWatchlistSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistSeriesBloc, WatchlistSeriesState>(
          builder: (context, state) {
            if (state is WatchlistSeriesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchlistSeriesError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.error),
              );
            } else if (state is WatchlistSeriesHasData) {
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

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
