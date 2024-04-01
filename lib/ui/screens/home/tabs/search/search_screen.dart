import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_application/data/repos/news_repo/news_repo.dart';
import 'package:news_application/data/repos/news_repo/news_repo_impl.dart';
import 'package:news_application/ui/widgets/app_error.dart';
import 'package:news_application/ui/widgets/app_loader.dart';

import '../../../../../model/article_response.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_theme.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = "searchScreen";
  final String sourceId;
  const SearchScreen({super.key, required this.sourceId});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController titleController = TextEditingController();
  late NewsRepoImpl newsRepoImpl;
  String title = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30))),
          backgroundColor: const Color(0xff39A552),
        title: Container(
          child: TextField(
            controller: titleController,
            onChanged: (value){
              title = value;
              setState(() {});
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Search",
              prefixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    title = "";
                    titleController.clear();
                  });
                },
                icon: const Icon(Icons.clear),
              ),
              suffixIcon: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/splash.png'),
              fit: BoxFit.cover),
        ),
        child: FutureBuilder(
            future: newsRepoImpl.loadArticlesList(widget.sourceId),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return ErrorView(error: snapshot.error.toString());
              } else if (snapshot.hasData) {
                return articlesList(snapshot.data!.articles!, context);
              } else {
                return const AppLoader();
              }
            }),
      ),
    );
  }

  Widget articlesList(List<Article?> articles, context) {
    List<Article?> filteredArticles = articles.where((article) {
      // Filter condition: check if the article title contains the entered text
      return article!.title!.toLowerCase().contains(title.toLowerCase());
    }).toList();
    return ListView.builder(
      itemCount: filteredArticles.length,
      itemBuilder: (context, index) {
        return articleWidget(filteredArticles[index]!, context);
      },
    );
  }

  Widget articleWidget(Article article, BuildContext context) {
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
