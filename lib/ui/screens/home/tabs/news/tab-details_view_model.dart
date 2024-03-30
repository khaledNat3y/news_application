import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:news_application/model/article_response.dart';
import '../../../../../data/repos/news_repo/news_repo.dart';
@injectable
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