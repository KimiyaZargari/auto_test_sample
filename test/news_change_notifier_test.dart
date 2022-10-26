import 'dart:math';

import 'package:auto_test_sample/article.dart';
import 'package:auto_test_sample/news_change_notifier.dart';
import 'package:auto_test_sample/news_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNewsService extends Mock implements NewsService {}

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
}
