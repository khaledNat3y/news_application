import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:news_application/data/repos/news_repo/news_repo.dart';
// import 'package:news_application/data/news_repo/data_sources/remote_data_sources/news_remote_data_sources.dart';
import 'package:news_application/model/source_response.dart';
import 'package:provider/provider.dart';

import '../../../../../data/repos/news_repo/data_sources/local_data_source/news_local_data_source.dart';
import '../../../../../data/repos/news_repo/data_sources/remote_data_source/news_remote_data_sources.dart';
import '../../../../../data/repos/news_repo/news_repo_impl.dart';
class TabsListViewModel extends ChangeNotifier {
  TabsListState state = TabsListState.loading;
  List<Source> sources = [];
  String errorMessage = '';
  NewsRepo repo;
  TabsListViewModel(this.repo);
  Future<void> loadTabsList(String categoryId) async{
    ///show loading
    state = TabsListState.loading;
    notifyListeners();
    try {
      SourceResponse sourcesResponse = await repo.loadTabsList(categoryId);
      ///show tabs list
      state = TabsListState.success;
      sources = sourcesResponse.sources!;
      notifyListeners();
    }catch(exception) {
      state = TabsListState.error;
      errorMessage = exception.toString();
      notifyListeners();
    }
  }
}
enum TabsListState {
  success,
  loading,
  error,
}