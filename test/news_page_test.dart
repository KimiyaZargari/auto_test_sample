import 'dart:math';

import 'package:auto_test_sample/article.dart';
import 'package:auto_test_sample/main.dart';
import 'package:auto_test_sample/news_change_notifier.dart';
import 'package:auto_test_sample/news_page.dart';
import 'package:auto_test_sample/news_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

class MockNewsService extends Mock implements NewsService {}

void main() {
  late MockNewsService mockNewsService;
  setUp(() {
    mockNewsService = MockNewsService();
  });
  final articlesUnEmptyList = [
    Article(title: 'test1', content: 'test1 content'),
    Article(title: 'test2', content: 'test2 content'),
    Article(title: 'test3', content: 'test3 content'),
  ];
  void arrangeNewsServiceReturnsUnEmptyListOfArticles() {
    when(() => mockNewsService.getArticles())
        .thenAnswer((invocation) async => articlesUnEmptyList);
  }

  void arrangeNewsServiceReturnsUnEmptyListOfArticlesAfter2Seconds() {
    when(() => mockNewsService.getArticles()).thenAnswer((invocation) async {
      return Future.delayed(const Duration(seconds: 2), () {
        return articlesUnEmptyList;
      });
    });
  }

  Widget createWidgetForTest() {
    return MaterialApp(
      title: 'News App',
      home: ChangeNotifierProvider(
        create: (_) => NewsChangeNotifier(mockNewsService),
        child: const NewsPage(),
      ),
    );
  }

  testWidgets('news page title is displayed', (widgetTester) async {
    arrangeNewsServiceReturnsUnEmptyListOfArticles();
    await widgetTester.pumpWidget(createWidgetForTest());
    expect(find.text('News'), findsOneWidget);
  });

  testWidgets('loading indicator is displayed while waiting for articles',
      (widgetTester) async {
    arrangeNewsServiceReturnsUnEmptyListOfArticlesAfter2Seconds();
    await widgetTester.pumpWidget(createWidgetForTest());
    await widgetTester.pump(const Duration(milliseconds: 500));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await widgetTester.pumpAndSettle();
  });
}
