import 'package:flutter/material.dart';
import 'package:news_application/data/api_manager.dart';
import 'package:news_application/model/article_response.dart';
import 'package:news_application/ui/widgets/app_error.dart';
import 'package:news_application/ui/widgets/app_loader.dart';
import 'package:news_application/utils/app_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../../utils/app_colors.dart';

class TabDetails extends StatelessWidget {
  final String sourceId;
  const TabDetails({super.key, required this.sourceId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ApiManager.loadArticlesList(sourceId), 
        builder: (context,snapshot) {
          if(snapshot.hasError) {
            return ErrorView(error: snapshot.error.toString());
          }else if(snapshot.hasData) {
            return articlesList(snapshot.data!.articles!);
          }else {
            return AppLoader();
          }
        });
  }

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
