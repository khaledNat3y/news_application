 import '../../../model/article_response.dart';
import '../../../model/source_response.dart';

abstract class NewsRepo {
  Future<SourceResponse> loadTabsList(String categoryId);

  Future<ArticlesResponse> loadArticlesList(String sourceId);
}