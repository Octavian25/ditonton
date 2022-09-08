import 'package:bloc_test/bloc_test.dart';
import 'package:core/presentation/bloc/movies/added_wachlist_movies/added_wachlist_movies_bloc.dart';
import 'package:core/presentation/bloc/movies/detail_movies/detail_movies/detail_movies_bloc.dart';
import 'package:core/presentation/bloc/movies/recommendation_movies/recommendation_movies_bloc.dart';
import 'package:core/presentation/pages/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockDetailMoviesBloc
    extends MockBloc<DetailMoviesEvent, DetailMoviesState>
    implements DetailMoviesBloc {}

class DetailMoviesEventFake extends Fake implements DetailMoviesEvent {}

class DetailMoviesStateFake extends Fake implements DetailMoviesState {}

class MockRecomendationMoviesBloc
    extends MockBloc<RecommendationMoviesEvent, RecommendationMoviesState>
    implements RecommendationMoviesBloc {}

class RecommendationMoviesEventFake extends Fake
    implements RecommendationMoviesEvent {}

class RecommendationMoviesStateFake extends Fake
    implements RecommendationMoviesState {}

class MockAddedWachlistMoviesBloc
    extends MockBloc<AddedWachlistMoviesEvent, AddedWachlistMoviesState>
    implements AddedWachlistMoviesBloc {}

class AddedWachlistMoviesEventFake extends Fake
    implements AddedWachlistMoviesEvent {}

class AddedWachlistMoviesStateFake extends Fake
    implements AddedWachlistMoviesState {}

void main() {
  late MockDetailMoviesBloc mockDetailMoviesBloc;
  late MockRecomendationMoviesBloc mockRecomendationMoviesBloc;
  late MockAddedWachlistMoviesBloc mockAddedWachlistMoviesBloc;

  setUp(() {
    mockAddedWachlistMoviesBloc = MockAddedWachlistMoviesBloc();
    mockRecomendationMoviesBloc = MockRecomendationMoviesBloc();
    mockDetailMoviesBloc = MockDetailMoviesBloc();
  });

  setUpAll(() {
    registerFallbackValue(RecommendationMoviesEventFake());
    registerFallbackValue(RecommendationMoviesStateFake());
    registerFallbackValue(DetailMoviesEventFake());
    registerFallbackValue(DetailMoviesStateFake());
    registerFallbackValue(AddedWachlistMoviesEventFake());
    registerFallbackValue(AddedWachlistMoviesStateFake());
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DetailMoviesBloc>(
            create: (context) => mockDetailMoviesBloc),
        BlocProvider<RecommendationMoviesBloc>(
            create: (context) => mockRecomendationMoviesBloc),
        BlocProvider<AddedWachlistMoviesBloc>(
            create: (context) => mockAddedWachlistMoviesBloc),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Watchlist detail content return loading',
      (WidgetTester tester) async {
    when(() => mockDetailMoviesBloc.state).thenReturn(DetailMoviesLoading());

    final centerwithcircleloading = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));
    expect(centerwithcircleloading, findsWidgets);
  });

  testWidgets('Watchlist detail content Error Text',
      (WidgetTester tester) async {
    when(() => mockDetailMoviesBloc.state)
        .thenReturn(DetailMoviesError("Error Get Detail Movie"));

    final watchlistButtonIcon = find.byType(Text);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));
    expect(watchlistButtonIcon, findsWidgets);
  });

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockDetailMoviesBloc.state)
        .thenReturn(DetailMoviesHasData(testMovieDetail));
    when(() => mockRecomendationMoviesBloc.state)
        .thenReturn(RecommendationMoviesHasData(testMovieList));
    when(() => mockAddedWachlistMoviesBloc.state)
        .thenReturn(IsAddedWatchList(false, "Error Get Detail Movie"));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockDetailMoviesBloc.state)
        .thenReturn(DetailMoviesHasData(testMovieDetail));
    when(() => mockRecomendationMoviesBloc.state)
        .thenReturn(RecommendationMoviesHasData(testMovieList));
    when(() => mockAddedWachlistMoviesBloc.state)
        .thenReturn(IsAddedWatchList(true, "Error Get Detail Movie"));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when removed from watchlist',
      (WidgetTester tester) async {
    when(() => mockDetailMoviesBloc.state)
        .thenReturn(DetailMoviesHasData(testMovieDetail));
    when(() => mockRecomendationMoviesBloc.state)
        .thenReturn(RecommendationMoviesHasData(testMovieList));
    when(() => mockAddedWachlistMoviesBloc.state)
        .thenReturn(IsAddedWatchList(true, 'Removed from Watchlist'));
    whenListen(
        mockAddedWachlistMoviesBloc,
        Stream.fromIterable([
          AddedWachlistMoviesInitial(),
          IsAddedWatchList(
              true, AddedWachlistMoviesBloc.watchlistRemoveSuccessMessage)
        ]));
    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.check), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Removed from Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(() => mockDetailMoviesBloc.state)
        .thenReturn(DetailMoviesHasData(testMovieDetail));
    when(() => mockRecomendationMoviesBloc.state)
        .thenReturn(RecommendationMoviesHasData(testMovieList));
    when(() => mockAddedWachlistMoviesBloc.state)
        .thenReturn(IsAddedWatchList(false, 'Added to Watchlist'));
    whenListen(
        mockAddedWachlistMoviesBloc,
        Stream.fromIterable([
          AddedWachlistMoviesInitial(),
          IsAddedWatchList(
              true, AddedWachlistMoviesBloc.watchlistAddSuccessMessage)
        ]));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(() => mockDetailMoviesBloc.state)
        .thenReturn(DetailMoviesHasData(testMovieDetail));
    when(() => mockRecomendationMoviesBloc.state)
        .thenReturn(RecommendationMoviesHasData(testMovieList));
    when(() => mockAddedWachlistMoviesBloc.state)
        .thenReturn(IsAddedWatchList(false, 'Failed'));
    whenListen(
        mockAddedWachlistMoviesBloc,
        Stream.fromIterable([
          AddedWachlistMoviesInitial(),
          IsAddedWatchList(false, "Error Message")
        ]));
    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Error Message'), findsOneWidget);
  });
}
