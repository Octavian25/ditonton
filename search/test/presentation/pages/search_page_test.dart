// ignore_for_file: depend_on_referenced_packages

import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:search/presentation/bloc/search_movie/search_movie_bloc.dart';
import 'package:search/presentation/pages/search_page.dart';
import 'package:mocktail/mocktail.dart';

class MockSearchMovieBloc extends MockBloc<SearchMovieEvent, SearchMovieState>
    implements SearchMovieBloc {}

class SearchMovieEventFake extends Fake implements SearchMovieEvent {}

class SearchMovieStateFake extends Fake implements SearchMovieState {}

void main() {
  late MockSearchMovieBloc mockSearchMovieBloc;

  setUp(() {
    mockSearchMovieBloc = MockSearchMovieBloc();
  });

  setUpAll(() {
    registerFallbackValue(SearchMovieEventFake());
    registerFallbackValue(SearchMovieStateFake());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<SearchMovieBloc>(
      create: (context) => mockSearchMovieBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    'should return Circular Progress Indicator',
    (widgetTester) async {
      when(() => mockSearchMovieBloc.state).thenReturn(SearchMovieLoading());
      final result = find.byType(CircularProgressIndicator);
      await widgetTester.pumpWidget(_makeTestableWidget(const SearchPage()));
      expect(result, findsOneWidget);
    },
  );

  testWidgets(
    'should return Error Text',
    (widgetTester) async {
      when(() => mockSearchMovieBloc.state)
          .thenReturn(const SearchMovieError("Cant Get Movie Data"));
      final result = find.text("Cant Get Movie Data");
      await widgetTester.pumpWidget(_makeTestableWidget(const SearchPage()));
      expect(result, findsOneWidget);
    },
  );

  testWidgets(
    'should return Movie List',
    (widgetTester) async {
      when(() => mockSearchMovieBloc.state)
          .thenReturn(SearchMovieHasData(testMovieList));
      final result = find.byType(MovieCard);
      await widgetTester.pumpWidget(_makeTestableWidget(const SearchPage()));
      expect(result, findsOneWidget);
    },
  );
}
