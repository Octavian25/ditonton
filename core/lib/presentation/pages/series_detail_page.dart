import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/series_detail.dart';
import 'package:core/presentation/bloc/series/added_watchlist_series/added_watchlist_series_bloc.dart';
import 'package:core/presentation/bloc/series/detail_series/detail_series_bloc.dart';
import 'package:core/presentation/bloc/series/recommendation_series/recommendation_series_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SeriesDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-series';

  final int id;
  const SeriesDetailPage({required this.id});

  @override
  _SeriesDetailPageState createState() => _SeriesDetailPageState();
}

class _SeriesDetailPageState extends State<SeriesDetailPage> {
  @override
  void initState() {
    super.initState();

    context.read<DetailSeriesBloc>().add(FetchDetailSeries(widget.id));
    context
        .read<AddedWatchlistSeriesBloc>()
        .add(FetchAddedWatchlistSeries(widget.id));
    context
        .read<RecommendationSeriesBloc>()
        .add(FetchRecommendationSeries(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DetailSeriesBloc, DetailSeriesState>(
        builder: (context, state) {
          if (state is DetailSeriesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DetailSeriesError) {
            return Text(state.error);
          } else if (state is DetailSeriesHasData) {
            final series = state.result;
            return SafeArea(
              child: DetailContent(series),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final SeriesDetail series;

  const DetailContent(
    this.series,
  );

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${series.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              series.name,
                              style: kHeading5,
                            ),
                            BlocListener<AddedWatchlistSeriesBloc,
                                AddedWatchlistSeriesState>(
                              listener: (context, state) {
                                if (state is IsAddedWatchlistSeries) {
                                  if (state.message ==
                                          AddedWatchlistSeriesBloc
                                              .watchlistAddSuccessMessage ||
                                      state.message ==
                                          AddedWatchlistSeriesBloc
                                              .watchlistRemoveSuccessMessage) {
                                    ScaffoldMessenger.of(context)
                                      ..hideCurrentSnackBar()
                                      ..showSnackBar(SnackBar(
                                          content: Text(state.message)));
                                  } else {
                                    if (state.message == "Initial Message") {
                                      return;
                                    }
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: Text(state.message),
                                          );
                                        });
                                  }
                                }
                              },
                              child: BlocBuilder<AddedWatchlistSeriesBloc,
                                  AddedWatchlistSeriesState>(
                                builder: (context, state) {
                                  if (state is IsAddedWatchlistSeries) {
                                    return ElevatedButton(
                                      onPressed: () async {
                                        if (!state.result) {
                                          context
                                              .read<AddedWatchlistSeriesBloc>()
                                              .add(AddToWatchListSeries(
                                                  series, context));
                                        } else {
                                          context
                                              .read<AddedWatchlistSeriesBloc>()
                                              .add(RemoveFromWatchListSeries(
                                                  series, context));
                                        }
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          state.result
                                              ? const Icon(Icons.check)
                                              : const Icon(Icons.add),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Text('Watchlist'),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return ElevatedButton(
                                      onPressed: null,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: const [
                                          CircularProgressIndicator.adaptive()
                                        ],
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                            Text(
                              _showGenres(series.genres),
                            ),
                            Text(
                              series.numberOfEpisodes.toString(),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: series.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${series.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              series.overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<RecommendationSeriesBloc,
                                RecommendationSeriesState>(
                              builder: (context, state) {
                                if (state is RecommendationSeriesLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is RecommendationSeriesError) {
                                  return Text(state.error);
                                } else if (state
                                    is RecommendationSeriesHasData) {
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final movie = state.result[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                SeriesDetailPage.ROUTE_NAME,
                                                arguments: movie.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                                placeholder: (context, url) =>
                                                    const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: state.result.length,
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}
