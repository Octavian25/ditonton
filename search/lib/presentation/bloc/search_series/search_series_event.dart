part of 'search_series_bloc.dart';

@immutable
abstract class SearchSeriesEvent {
  const SearchSeriesEvent();
}

class OnQuerySeriesChanged extends SearchSeriesEvent {
  final String query;

  const OnQuerySeriesChanged(this.query);
}
