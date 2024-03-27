import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/data/repos/news_repo/news_repo.dart';
import 'package:news_application/model/source_response.dart';

class TabsListViewModel extends Cubit<TabsListState> {
  NewsRepo repo;
  TabsListViewModel(this.repo):super(TabsListState());
  Future<void> loadTabsList(String categoryId) async{
    ///show loading
    // state = ApiState.loading;
    // notifyListeners();
    emit(TabsListState(listApiState: ApiState.loading));
    try {
      SourceResponse sourcesResponse = await repo.loadTabsList(categoryId);
      ///show tabs list
      emit(TabsListState(listApiState: ApiState.success,
          sources: sourcesResponse.sources!));

    }catch(exception) {

      emit(TabsListState(listApiState: ApiState.error ,
          errorMessage: exception.toString()));
    }
  }
}
class TabsListState {
  List<Source> sources = [];
  String errorMessage = '';
  ApiState listApiState;
  TabsListState({this.listApiState = ApiState.loading,
    this.sources = const [] ,
    this.errorMessage = ""});
}
enum ApiState {
  success,
  loading,
  error,
}