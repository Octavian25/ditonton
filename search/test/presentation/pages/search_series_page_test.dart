// ignore_for_file: depend_on_referenced_packages

import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/presentation/widgets/series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:search/presentation/bloc/search_series/search_series_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:search/presentation/pages/search_series_page.dart';

class MockSearchSeriesBloc
    extends MockBloc<SearchSeriesEvent, SearchSeriesState>
    implements SearchSeriesBloc {}

class SearchSeriesEventFake extends Fake implements SearchSeriesEvent {}

class SearchSeriesStateFake extends Fake implements SearchSeriesState {}

void main() {
  late MockSearchSeriesBloc mockSearchSeriesBloc;

  setUp(() {
    mockSearchSeriesBloc = MockSearchSeriesBloc();
  });

  setUpAll(() {
    registerFallbackValue(SearchSeriesEventFake());
    registerFallbackValue(SearchSeriesStateFake());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<SearchSeriesBloc>(
      create: (context) => mockSearchSeriesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    'should return Circular Progress Indicator',
    (widgetTester) async {
      when(() => mockSearchSeriesBloc.state).thenReturn(SearchSeriesLoading());
      final result = find.byType(CircularProgressIndicator);
      await widgetTester
          .pumpWidget(_makeTestableWidget(const SearchSeriesPage()));
      expect(result, findsOneWidget);
    },
  );

  testWidgets(
    'should return Error Text',
    (widgetTester) async {
      when(() => mockSearchSeriesBloc.state)
          .thenReturn(const SearchSeriesError("Cant Get Movie Data"));
      final result = find.text("Cant Get Movie Data");
      await widgetTester
          .pumpWidget(_makeTestableWidget(const SearchSeriesPage()));
      expect(result, findsOneWidget);
    },
  );

  testWidgets(
    'should return Movie List',
    (widgetTester) async {
      when(() => mockSearchSeriesBloc.state)
          .thenReturn(SearchSeriesHasData(testSeriesList));
      final result = find.byType(SeriesCard);
      await widgetTester
          .pumpWidget(_makeTestableWidget(const SearchSeriesPage()));
      expect(result, findsOneWidget);
    },
  );
}
