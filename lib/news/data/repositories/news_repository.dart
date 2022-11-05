import 'package:auto_test_sample/news/domain/repositories/i_news_repository.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import '../../../article/data/models/article_model.dart';

/// A News service simulating communication with a server.
class NewsRepository implements INewsRepository {
  static final NewsRepository _singleton = NewsRepository._internal();

  NewsRepository._internal();

  factory NewsRepository() {
    return _singleton;
  }

  final _articles = List.generate(
    10,
    (_) => ArticleModel(
      title: lorem(paragraphs: 1, words: 3),
      content: lorem(paragraphs: 10, words: 500),
    ),
  );

  @override
  Future<List<ArticleModel>> getArticles() async {
    await Future.delayed(const Duration(seconds: 1));
    return _articles;
  }
}
