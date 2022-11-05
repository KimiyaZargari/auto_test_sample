import 'package:auto_test_sample/article/domain/entities/article.dart';
import 'package:auto_test_sample/news/domain/repositories/i_news_repository.dart';
import 'package:auto_test_sample/news/presentation/notifiers/news_change_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNewsService extends Mock implements INewsRepository {}

void main() {
  late NewsChangeNotifier sut;
  late MockNewsService mockNewsService;
  setUp(() {
    mockNewsService = MockNewsService();
    sut = NewsChangeNotifier(mockNewsService);
  });

  test('initial values are correct', () {
    expect(sut.articles, []);
    expect(sut.isLoading, false);
  });
  group('getArticles', () {
    final articlesUnEmptyList = [
      Article(title: 'test1', content: 'test1 content'),
      Article(title: 'test2', content: 'test2 content'),
      Article(title: 'test3', content: 'test3 content'),
    ];
    void arrangeNewsServiceReturnsUnEmptyListOfArticles() {
      when(() => mockNewsService.getArticles())
          .thenAnswer((invocation) async => articlesUnEmptyList);
    }

    test('gets articles', () async {
      arrangeNewsServiceReturnsUnEmptyListOfArticles();
      await sut.getArticles();
      verify(() => mockNewsService.getArticles()).called(1);
    });
    test(
        'indicates loading of data, setting articles to the data loaded, and finished loading',
        () async {
      arrangeNewsServiceReturnsUnEmptyListOfArticles();
      final future = sut.getArticles();
      expect(sut.isLoading, true);
      await future;
      expect(sut.articles, articlesUnEmptyList);
      expect(sut.isLoading, false);
    });
  });
}
