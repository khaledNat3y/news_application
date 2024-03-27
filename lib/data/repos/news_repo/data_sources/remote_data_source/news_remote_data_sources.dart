import 'package:news_application/model/source_response.dart';

import '../../../../../model/article_response.dart';

// import '../../../../model/article_response.dart';

abstract class NewsRemoteDataSource {

  Future<SourceResponse> loadTabsList(String categoryId);

  Future<ArticlesResponse> loadArticlesList(String sourceId);
}
