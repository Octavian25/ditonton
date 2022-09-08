import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/presentation/bloc/series/popular_series/popular_series_bloc.dart';
import 'package:core/presentation/pages/popular_series_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPopularSeriesBloc
    extends MockBloc<PopularSeriesEvent, PopularSeriesState>
    implements PopularSeriesBloc {}

class PopularSeriesEventFake extends Fake implements PopularSeriesEvent {}

class PopularSeriesStateFake extends Fake implements PopularSeriesState {}

void main() {
  late MockPopularSeriesBloc mockPopularSeriesBloc;

  setUp(() {
    mockPopularSeriesBloc = MockPopularSeriesBloc();
  });

  setUpAll(() {
    registerFallbackValue(PopularSeriesEventFake());
    registerFallbackValue(PopularSeriesStateFake());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularSeriesBloc>(
      create: (context) => mockPopularSeriesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockPopularSeriesBloc.state).thenReturn(PopularSeriesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(PopularSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockPopularSeriesBloc.state)
        .thenReturn(PopularSeriesHasData(testSeriesList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockPopularSeriesBloc.state)
        .thenReturn(PopularSeriesError("Error Message"));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(PopularSeriesPage()));

    expect(textFinder, findsOneWidget);
  });
}
