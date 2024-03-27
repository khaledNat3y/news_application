import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:news_application/data/repos/news_repo/news_repo.dart';
// import 'package:news_application/data/news_repo/data_sources/remote_data_sources/news_remote_data_sources.dart';
import 'package:news_application/model/article_response.dart';
import 'package:news_application/ui/screens/home/tabs/news/tab-details_view_model.dart';
import 'package:news_application/ui/widgets/app_error.dart';
import 'package:news_application/ui/widgets/app_loader.dart';
import 'package:news_application/utils/app_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import '../../../../../../data/repos/news_repo/data_sources/local_data_source/news_loacal_data_source_impl.dart';
import '../../../../../../data/repos/news_repo/data_sources/remote_data_source/news_remote_data_source_impl.dart';
import '../../../../../../data/repos/news_repo/news_repo_impl.dart';
import '../../../../../../utils/app_colors.dart';
import '../tabs_list_view_moder.dart';

class TabDetails extends StatefulWidget {
  final String sourceId;
  const TabDetails({super.key, required this.sourceId});

  @override
  State<TabDetails> createState() => _TabDetailsState();
}

class _TabDetailsState extends State<TabDetails> {
  TabDetailsViewModel viewModel = TabDetailsViewModel(
      NewsRepoImpl(
        NewsRemoteDataSourceImpl(),
        NewsLocalDataSourceImpl(),
        InternetConnectionChecker(),

      ));
  @override
  void initState() {
    viewModel.loadArticles(widget.sourceId);

  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Builder(
        builder: (context) {
          viewModel = Provider.of(context);
          if(viewModel.state == TabDetailsState.error) {
            return ErrorView(error: viewModel.errorMessage,onRefreshClick: (){
              viewModel.loadArticles(widget.sourceId);
            },);
          }else if(viewModel.state == TabDetailsState.success) {
            return articlesList(viewModel.articles);
          }else {
            return const AppLoader();
          }
        },
      )
    );
  }

  // if(snapshot.hasError) {
  Widget articlesList(List<Article?> articles) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context,index) {
        return articleWidget(context,articles[index]!,);
      },
    );
  }

  Widget articleWidget(BuildContext context, Article article) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: article.urlToImage!,
                fit: BoxFit.cover,
                height: MediaQuery.sizeOf(context).height * 0.25,
                placeholder: (_,__) => Center(child: CircularProgressIndicator()),
                errorWidget: (_,__,___) => Center(child: Icon(Icons.error)),
              )
          ),
          Text(article.source?.name ?? "",
            style: TextStyle(color: AppColors.gray),),
          SizedBox(height: 10,),
          Text(article.title ?? "",
            style: AppTheme.articleTitleStyle,textAlign: TextAlign.center,
          ),
          SizedBox(height: 10,),
          Text(article.publishedAt ?? "",
            style: TextStyle(color: AppColors.gray),textAlign: TextAlign.end,
          ),
        ],
      ),
    );
  }
}
