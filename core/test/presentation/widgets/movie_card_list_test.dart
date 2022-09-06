import 'package:core/core.dart';
import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Card Should Have Title', (WidgetTester tester) async {
    final titleText = find.text(testMovie.title ?? "-");

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Column(
          children: [MovieCard(testMovie)],
        ),
      ),
    ));
    expect(titleText, findsWidgets);
  });

  testWidgets('Card Should Have Overview', (WidgetTester tester) async {
    final titleText = find.text(testMovie.overview ?? "-");

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Column(
          children: [MovieCard(testMovie)],
        ),
      ),
    ));
    expect(titleText, findsWidgets);
  });

  testWidgets('Card Should Have Image', (WidgetTester tester) async {
    final titleText = find.byType(ClipRRect);

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Column(
          children: [MovieCard(testMovie)],
        ),
      ),
    ));
    expect(titleText, findsWidgets);
  });
}
