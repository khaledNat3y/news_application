import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:news_application/data/repos/news_repo/data_sources/local_data_source/news_loacal_data_source_impl.dart';

import '../../../../../model/article_response.dart';
import '../../../../../model/source_response.dart';
import '../../../../../utils/firestore_constants.dart';

abstract class NewsLocalDataSource {
  Future<SourceResponse?> loadTabsList(String categoryId);

  Future<ArticlesResponse?> loadArticlesList(String sourceId);

  Future<void> saveTabsResponse(String sourceId, SourceResponse response);

  Future<void> saveArticles(String sourceId, ArticlesResponse response);

  }

