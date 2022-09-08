import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/presentation/bloc/series/top_rated_series/top_rated_series_bloc.dart';
import 'package:core/presentation/pages/top_rated_series_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTopRatedSeriesBloc
    extends MockBloc<TopRatedSeriesEvent, TopRatedSeriesState>
    implements TopRatedSeriesBloc {}

class TopRatedSeriesEventFake extends Fake implements TopRatedSeriesEvent {}

class TopRatedSeriesStateFake extends Fake implements TopRatedSeriesState {}

void main() {
  late MockTopRatedSeriesBloc mockTopRatedSeriesBloc;

  setUp(() {
    mockTopRatedSeriesBloc = MockTopRatedSeriesBloc();
  });

  setUpAll(() {
    registerFallbackValue(TopRatedSeriesEventFake());
    registerFallbackValue(TopRatedSeriesStateFake());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedSeriesBloc>(
      create: (context) => mockTopRatedSeriesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockTopRatedSeriesBloc.state)
        .thenReturn(TopRatedSeriesLoading());

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => mockTopRatedSeriesBloc.state)
        .thenReturn(TopRatedSeriesHasData(testSeriesList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockTopRatedSeriesBloc.state)
        .thenReturn(TopRatedSeriesError("Error Message"));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedSeriesPage()));

    expect(textFinder, findsOneWidget);
  });
}
