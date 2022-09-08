import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/presentation/bloc/series/added_watchlist_series/added_watchlist_series_bloc.dart';
import 'package:core/presentation/bloc/series/detail_series/detail_series_bloc.dart';
import 'package:core/presentation/bloc/series/recommendation_series/recommendation_series_bloc.dart';
import 'package:core/presentation/pages/series_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDetailSeriesBloc
    extends MockBloc<DetailSeriesEvent, DetailSeriesState>
    implements DetailSeriesBloc {}

class DetailSeriesEventFake extends Fake implements DetailSeriesEvent {}

class DetailSeriesStateFake extends Fake implements DetailSeriesState {}

class MockRecommendationSeriesBloc
    extends MockBloc<RecommendationSeriesEvent, RecommendationSeriesState>
    implements RecommendationSeriesBloc {}

class RecommendationSeriesEventFake extends Fake
    implements RecommendationSeriesEvent {}

class RecommendationSeriesStateFake extends Fake
    implements RecommendationSeriesState {}

class MockAddedWatchlistSeriesBloc
    extends MockBloc<AddedWatchlistSeriesEvent, AddedWatchlistSeriesState>
    implements AddedWatchlistSeriesBloc {}

class AddedWatchlistSeriesEventFake extends Fake
    implements AddedWatchlistSeriesEvent {}

class AddedWatchlistSeriesStateFake extends Fake
    implements AddedWatchlistSeriesState {}

void main() {
  late MockDetailSeriesBloc mockDetailSeriesBloc;
  late MockRecommendationSeriesBloc mockRecommendationSeriesBloc;
  late MockAddedWatchlistSeriesBloc mockAddedWatchlistSeriesBloc;

  setUp(() {
    mockDetailSeriesBloc = MockDetailSeriesBloc();
    mockRecommendationSeriesBloc = MockRecommendationSeriesBloc();
    mockAddedWatchlistSeriesBloc = MockAddedWatchlistSeriesBloc();
  });

  setUpAll(() {
    registerFallbackValue(RecommendationSeriesEventFake());
    registerFallbackValue(RecommendationSeriesStateFake());
    registerFallbackValue(DetailSeriesEventFake());
    registerFallbackValue(DetailSeriesStateFake());
    registerFallbackValue(AddedWatchlistSeriesEventFake());
    registerFallbackValue(AddedWatchlistSeriesStateFake());
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DetailSeriesBloc>(
          create: (context) => mockDetailSeriesBloc,
        ),
        BlocProvider<RecommendationSeriesBloc>(
          create: (context) => mockRecommendationSeriesBloc,
        ),
        BlocProvider<AddedWatchlistSeriesBloc>(
          create: (context) => mockAddedWatchlistSeriesBloc,
        )
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when series not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockDetailSeriesBloc.state)
        .thenReturn(DetailSeriesHasData(testSeriesDetail));
    when(() => mockRecommendationSeriesBloc.state)
        .thenReturn(RecommendationSeriesHasData(testSeriesList));
    when(() => mockAddedWatchlistSeriesBloc.state)
        .thenReturn(IsAddedWatchlistSeries(false, "Error Get Detail Movie"));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(const SeriesDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when series is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockDetailSeriesBloc.state)
        .thenReturn(DetailSeriesHasData(testSeriesDetail));
    when(() => mockRecommendationSeriesBloc.state)
        .thenReturn(RecommendationSeriesHasData(testSeriesList));
    when(() => mockAddedWatchlistSeriesBloc.state)
        .thenReturn(IsAddedWatchlistSeries(true, "Error Get Detail Movie"));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(const SeriesDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(() => mockDetailSeriesBloc.state)
        .thenReturn(DetailSeriesHasData(testSeriesDetail));
    when(() => mockRecommendationSeriesBloc.state)
        .thenReturn(RecommendationSeriesHasData(testSeriesList));
    when(() => mockAddedWatchlistSeriesBloc.state)
        .thenReturn(IsAddedWatchlistSeries(false, "Added to Watchlist"));
    whenListen(
        mockAddedWatchlistSeriesBloc,
        Stream.fromIterable([
          AddedWatchlistSeriesInitial(),
          IsAddedWatchlistSeries(
              true, AddedWatchlistSeriesBloc.watchlistAddSuccessMessage)
        ]));
    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(const SeriesDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when removed to watchlist',
      (WidgetTester tester) async {
    when(() => mockDetailSeriesBloc.state)
        .thenReturn(DetailSeriesHasData(testSeriesDetail));
    when(() => mockRecommendationSeriesBloc.state)
        .thenReturn(RecommendationSeriesHasData(testSeriesList));
    when(() => mockAddedWatchlistSeriesBloc.state)
        .thenReturn(IsAddedWatchlistSeries(false, "Added to Watchlist"));
    whenListen(
        mockAddedWatchlistSeriesBloc,
        Stream.fromIterable([
          AddedWatchlistSeriesInitial(),
          IsAddedWatchlistSeries(
              true, AddedWatchlistSeriesBloc.watchlistRemoveSuccessMessage)
        ]));
    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(const SeriesDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text(AddedWatchlistSeriesBloc.watchlistRemoveSuccessMessage),
        findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(() => mockDetailSeriesBloc.state)
        .thenReturn(DetailSeriesHasData(testSeriesDetail));
    when(() => mockRecommendationSeriesBloc.state)
        .thenReturn(RecommendationSeriesHasData(testSeriesList));
    when(() => mockAddedWatchlistSeriesBloc.state)
        .thenReturn(IsAddedWatchlistSeries(false, "Failed"));
    whenListen(
        mockAddedWatchlistSeriesBloc,
        Stream.fromIterable([
          AddedWatchlistSeriesInitial(),
          IsAddedWatchlistSeries(false, "Failed")
        ]));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(const SeriesDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
