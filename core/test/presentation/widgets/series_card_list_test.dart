import 'package:core/presentation/widgets/series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  testWidgets('Card Should Have Title', (WidgetTester tester) async {
    final titleText = find.text(testSeries.name ?? "-");

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Column(
          children: [SeriesCard(testSeries)],
        ),
      ),
    ));
    expect(titleText, findsWidgets);
  });

  testWidgets('Card Should Have Overview', (WidgetTester tester) async {
    final titleText = find.text(testSeries.overview ?? "-");

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Column(
          children: [SeriesCard(testSeries)],
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
          children: [SeriesCard(testSeries)],
        ),
      ),
    ));
    expect(titleText, findsWidgets);
  });
}
