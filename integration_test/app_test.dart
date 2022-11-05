import 'package:auto_test_sample/article/data/models/article_model.dart';
import 'package:auto_test_sample/article/presentation/pages/article_page.dart';
import 'package:auto_test_sample/news/domain/repositories/i_news_repository.dart';
import 'package:auto_test_sample/news/presentation/notifiers/news_change_notifier.dart';
import 'package:auto_test_sample/news/presentation/pages/news_page.dart';
import 'package:auto_test_sample/news/data/repositories/news_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

class MockNewsService extends Mock implements INewsRepository {}

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
  testWidgets(
      'Tapping on the first article opens the article page where the article content is displayed',
      (widgetTester) async {
    arrangeNewsServiceReturnsUnEmptyListOfArticles();
    await widgetTester.pumpWidget(createWidgetForTest());
    await widgetTester.pump();
    await widgetTester.tap(find.text(articlesUnEmptyList.first.title));
    await widgetTester.pumpAndSettle();
    expect(find.byType(NewsPage), findsNothing);
    expect(find.byType(ArticlePage), findsOneWidget);
    expect(find.text(articlesUnEmptyList.first.content), findsOneWidget);
  });
}
