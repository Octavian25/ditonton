part of 'top_rated_bloc.dart';

@immutable
abstract class TopRatedEvent extends Equatable {}

class FetchTopRated extends TopRatedEvent {
  @override
  List<Object?> get props => [];
}
