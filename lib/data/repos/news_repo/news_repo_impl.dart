import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:news_application/data/repos/news_repo/news_repo.dart';

import '../../../model/article_response.dart';
import '../../../model/source_response.dart';
import 'data_sources/local_data_source/news_local_data_source.dart';
import 'data_sources/remote_data_source/news_remote_data_sources.dart';
@Injectable(as: NewsRepo)
class NewsRepoImpl extends NewsRepo{
  NewsRemoteDataSource newsRemoteDataSource;
  NewsLocalDataSource newsLocalDataSource;
  InternetConnectionChecker connectionsChecker;
  NewsRepoImpl(this.newsRemoteDataSource, this.newsLocalDataSource, this.connectionsChecker);
  Future<SourceResponse> loadTabsList(String categoryId) async {
    //todo: replace this condition with internet check
    if(await connectionsChecker.hasConnection){
      SourceResponse response = await newsRemoteDataSource.loadTabsList(categoryId);
      newsLocalDataSource.saveTabsResponse(categoryId, response);
      return response;
    }else {
      SourceResponse? response = await newsLocalDataSource.loadTabsList(categoryId);
      return response!;
    }
  }

  Future<ArticlesResponse> loadArticlesList(String sourceId) async {
    if(await connectionsChecker.hasConnection) {
      ArticlesResponse response = await newsRemoteDataSource.loadArticlesList(sourceId);
      newsLocalDataSource.saveArticles(sourceId, response);
      return response;
    }else {
      ArticlesResponse? response = await newsLocalDataSource.loadArticlesList(sourceId);
      return response;
    }
  }
}