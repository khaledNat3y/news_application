import 'package:flutter/material.dart';
import 'package:news_application/data/repos/news_repo/data_sources/local_data_source/news_local_data_source.dart';
import 'package:news_application/model/article_response.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:news_application/ui/screens/home/tabs/news/tabs_list_view_moder.dart';
// import '../../../../../data/news_repo/data_sources/remote_data_sources/news_remote_data_sources.dart';
import '../../../../../data/repos/news_repo/data_sources/local_data_source/news_loacal_data_source_impl.dart';
import '../../../../../data/repos/news_repo/data_sources/remote_data_source/news_remote_data_source_impl.dart';
import '../../../../../data/repos/news_repo/data_sources/remote_data_source/news_remote_data_sources.dart';
import '../../../../../data/repos/news_repo/news_repo.dart';
import '../../../../../data/repos/news_repo/news_repo_impl.dart';

class TabDetailsViewModel extends ChangeNotifier {
  TabDetailsState state = TabDetailsState.loading;
  List<Article> articles = [];
  String errorMessage = '';
  NewsRepo repo;
  TabDetailsViewModel(this.repo);
  Future<void> loadArticles(String sourceId) async{
    try {
      state = TabDetailsState.loading;
      notifyListeners();
      ArticlesResponse articlesResponse = await repo.loadArticlesList(sourceId);
      state = TabDetailsState.success;
      articles = articlesResponse.articles!;
      notifyListeners();
    }catch(exception) {
      state = TabDetailsState.error;
      errorMessage = exception.toString();
      notifyListeners();
    }
  }
}
enum TabDetailsState {
  success,
  loading,
  error,
}