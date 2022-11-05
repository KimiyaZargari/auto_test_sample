import 'package:auto_test_sample/core/domain/entities/no_param.dart';
import 'package:auto_test_sample/news/domain/repositories/i_news_repository.dart';
import 'package:auto_test_sample/news/domain/usecases/get_articles.dart';
import 'package:flutter/material.dart';

import '../../../article/domain/entities/article.dart';

class NewsChangeNotifier extends ChangeNotifier {
  final INewsRepository _newsRepository;

  NewsChangeNotifier(this._newsRepository);

  List<Article> _articles = [];

  List<Article> get articles => _articles;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> getArticles() async {
    _isLoading = true;
    notifyListeners();
    GetArticles getArticles = GetArticles(_newsRepository);
    _articles = await getArticles(NoParam());
    _isLoading = false;
    notifyListeners();
  }
}
