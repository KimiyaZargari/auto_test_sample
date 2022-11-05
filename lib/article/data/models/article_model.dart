import 'package:auto_test_sample/article/domain/entities/article.dart';

class ArticleModel extends Article {
  ArticleModel({
    required String title,
    required String content,
  }) : super(title: title, content: content);
}
