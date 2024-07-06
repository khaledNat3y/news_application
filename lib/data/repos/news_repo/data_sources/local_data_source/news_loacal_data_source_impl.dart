import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:news_application/data/repos/news_repo/data_sources/local_data_source/news_local_data_source.dart';
import 'package:news_application/data/repos/news_repo/news_repo.dart';

import '../../../../../model/article_response.dart';
import '../../../../../model/source_response.dart';
import '../../../../../utils/firestore_constants.dart';

@Injectable(as: NewsLocalDataSource)
class NewsLocalDataSourceImpl extends NewsLocalDataSource {
  Future<SourceResponse?> loadTabsList(String categoryId) async {
    CollectionReference tabsCollection = FirebaseFirestore.instance
        .collection(FireStoreConstants.tabsCollectionName);
    DocumentSnapshot documentSnapshot = await tabsCollection.doc(categoryId).get();
    Map json = documentSnapshot.data() as Map;
    return SourceResponse.fromJson(json);
  }

  Future<ArticlesResponse?> loadArticlesList(String sourceId) async {
    CollectionReference articlesCollection = FirebaseFirestore.instance
        .collection(FireStoreConstants.articlesCollection);
    DocumentSnapshot documentSnapshot = await articlesCollection.doc(sourceId).get();
    Map json = documentSnapshot.data() as Map;
    return ArticlesResponse.fromJson(json);
  }

  Future<void> saveTabsResponse(
      String sourceId, SourceResponse response) async {
    CollectionReference tabsCollection = FirebaseFirestore.instance
        .collection(FireStoreConstants.tabsCollectionName);
    await tabsCollection.doc().set(response.toJson());
  }

  Future<void> saveArticles(String sourceId, ArticlesResponse response) async {
    CollectionReference articlesCollection = FirebaseFirestore.instance
        .collection(FireStoreConstants.articlesCollection);
    await articlesCollection.doc().set(response.toJson());
  }
}
