import 'package:auto_test_sample/news/domain/repositories/i_news_repository.dart';

import '../../../article/domain/entities/article.dart';
import '../../../core/domain/entities/no_param.dart';
import '../../../core/domain/usecases/i_usecase.dart';

class GetArticles implements UseCase<List<Article>, NoParam> {
  INewsRepository repository;

  GetArticles(this.repository);

  @override
  Future<List<Article>> call(_) async {
    return await repository.getArticles();
  }
}
