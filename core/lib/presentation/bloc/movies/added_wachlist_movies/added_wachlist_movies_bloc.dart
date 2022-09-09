import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/domain/usecases/remove_watchlist.dart';
import 'package:core/domain/usecases/save_watchlist.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
part 'added_wachlist_movies_event.dart';
part 'added_wachlist_movies_state.dart';

class AddedWachlistMoviesBloc
    extends Bloc<AddedWachlistMoviesEvent, AddedWachlistMoviesState> {
  final MovieRepository movieRepository;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;
  final bool isTestingMode;
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';
  static const watchlistInitialMessage = 'Initial Message';
  AddedWachlistMoviesBloc(
      {required this.movieRepository,
      required this.saveWatchlist,
      required this.removeWatchlist,
      this.isTestingMode = false})
      : super(AddedWachlistMoviesInitial()) {
    on<FetchAddedWachlistMovies>((event, emit) async {
      final result = await movieRepository.isAddedToWatchlist(event.id);
      print("HASIL DARI FETCH $result");
      emit(IsAddedWatchList(result, watchlistInitialMessage));
    });
    on<RemoveFromWatchListMovies>(
      (event, emit) async {
        emit(AddedWachlistMoviesLoading());
        final result = await removeWatchlist.execute(event.movieDetail);
        await result.fold((l) async {
          final result =
              await movieRepository.isAddedToWatchlist(event.movieDetail.id);
          print("HASIL DARI REMOVE ERROR $result");
          emit(IsAddedWatchList(result, l.message));
        }, (r) async {
          final result =
              await movieRepository.isAddedToWatchlist(event.movieDetail.id);
          print("HASIL DARI REMOVE SUCCESS $result");
          emit(IsAddedWatchList(result, r));
        });
      },
    );
    on<AddToWatchListMovies>(
      (event, emit) async {
        emit(AddedWachlistMoviesLoading());
        final result = await saveWatchlist.execute(event.movieDetail);
        await result.fold((l) async {
          final result =
              await movieRepository.isAddedToWatchlist(event.movieDetail.id);
          print("HASIL DARI ADD FAILED $result");
          emit(IsAddedWatchList(result, l.message));
        }, (r) async {
          final result =
              await movieRepository.isAddedToWatchlist(event.movieDetail.id);
          print("HASIL DARI ADD SUCCESS $result");
          emit(IsAddedWatchList(result, r));
        });
      },
    );
  }
}
