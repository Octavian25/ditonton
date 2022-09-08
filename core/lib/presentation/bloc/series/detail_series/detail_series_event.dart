part of 'detail_series_bloc.dart';

@immutable
abstract class DetailSeriesEvent {}

class FetchDetailSeries extends DetailSeriesEvent {
  final int id;
  FetchDetailSeries(this.id);
}
