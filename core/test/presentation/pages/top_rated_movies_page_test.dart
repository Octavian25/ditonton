import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/presentation/bloc/movies/top_rated/top_rated_bloc.dart';
import 'package:core/presentation/pages/top_rated_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTopRatedBloc extends MockBloc<TopRatedEvent, TopRatedState>
    implements TopRatedBloc {}

class TopRatedEventFake extends Fake implements TopRatedEvent {}

class TopRatedStateFake extends Fake implements TopRatedState {}

void main() {
  late MockTopRatedBloc mockTopRatedBloc;

  setUp(() {
    mockTopRatedBloc = MockTopRatedBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedBloc>(
      create: (context) => mockTopRatedBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  setUpAll(() {
    registerFallbackValue(TopRatedStateFake());
    registerFallbackValue(TopRatedEventFake());
  });

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockTopRatedBloc.state).thenReturn(TopRatedLoading());

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => mockTopRatedBloc.state)
        .thenReturn(TopRatedHasData(testMovieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockTopRatedBloc.state)
        .thenReturn(TopRatedError("Error Message"));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
