import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:core/presentation/bloc/movies/added_wachlist_movies/added_wachlist_movies_bloc.dart';
import 'package:core/presentation/bloc/movies/detail_movies/detail_movies/detail_movies_bloc.dart';
import 'package:core/presentation/bloc/movies/recommendation_movies/recommendation_movies_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MovieDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-movies';

  final int id;
  const MovieDetailPage({required this.id});

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    context
        .read<RecommendationMoviesBloc>()
        .add(FetchRecommendationMovies(widget.id));
    context.read<DetailMoviesBloc>().add(FetchDetailMovies(widget.id));
    context
        .read<AddedWachlistMoviesBloc>()
        .add(FetchAddedWachlistMovies(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DetailMoviesBloc, DetailMoviesState>(
        builder: (context, state) {
          if (state is DetailMoviesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DetailMoviesError) {
            return Text(state.error);
          } else if (state is DetailMoviesHasData) {
            final movie = state.result;
            return SafeArea(
              child: DetailContent(
                movie,
              ),
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
  final MovieDetail movie;

  const DetailContent(
    this.movie,
  );

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
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
                              movie.title,
                              style: kHeading5,
                            ),
                            BlocListener<AddedWachlistMoviesBloc,
                                AddedWachlistMoviesState>(
                              listener: (context, state) {
                                if (state is IsAddedWatchList) {
                                  if (state.message ==
                                          AddedWachlistMoviesBloc
                                              .watchlistAddSuccessMessage ||
                                      state.message ==
                                          AddedWachlistMoviesBloc
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
                              child: BlocBuilder<AddedWachlistMoviesBloc,
                                  AddedWachlistMoviesState>(
                                builder: (context, state) {
                                  if (state is IsAddedWatchList) {
                                    return ElevatedButton(
                                      onPressed: () async {
                                        if (!state.result) {
                                          context
                                              .read<AddedWachlistMoviesBloc>()
                                              .add(AddToWatchListMovies(
                                                  movie, context));
                                        } else {
                                          context
                                              .read<AddedWachlistMoviesBloc>()
                                              .add(RemoveFromWatchListMovies(
                                                  movie, context));
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
                              _showGenres(movie.genres),
                            ),
                            Text(
                              _showDuration(movie.runtime),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: movie.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${movie.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              movie.overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<RecommendationMoviesBloc,
                                RecommendationMoviesState>(
                              builder: (context, state) {
                                if (state is RecommendationMoviesLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is RecommendationMoviesError) {
                                  return Text(state.error);
                                } else if (state
                                    is RecommendationMoviesHasData) {
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
                                                MovieDetailPage.ROUTE_NAME,
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

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
