import '../../../article/domain/entities/article.dart';

abstract class INewsRepository {
  Future<List<Article>> getArticles();
}
