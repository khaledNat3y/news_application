import 'package:flutter/material.dart';
import 'package:news_application/model/category.dart';
import 'package:news_application/ui/screens/home/tabs/categories/categories_tab.dart';
import 'package:news_application/ui/screens/home/tabs/news/tabs_list/tabs_list.dart';
import 'package:news_application/ui/screens/home/tabs/settings/settings.dart';
import 'package:news_application/utils/app_theme.dart';

import '../../../../utils/app_colors.dart';

class Home extends StatefulWidget {
  static const String routeName = "home";

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Widget body;
   bool canPop= false;
  @override
  void initState() {
    body = CategoriesTab(onCategoryClick: onCategoryClick);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: ()async{
          if(body is CategoriesTab) {
            return true;
          }else {
            setState(() {
              body = CategoriesTab(onCategoryClick: onCategoryClick);
            });
            return false;
          }
        },
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/pattern.png"),
            ),
          ),
          child: Scaffold(
            drawer: buildDrawer(),
              appBar: AppBar(
                toolbarHeight: MediaQuery.sizeOf(context).height * 0.1,
                title: Text("News App",
                  style: AppTheme.titleStyle.copyWith(color: AppColors.white),),
                centerTitle: true,
              ),
              body: body,
          ),
        ),
      ),
    );
  }

  Drawer buildDrawer() {
    return Drawer(
      // shape: RoundedRectangleBorder(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: AppColors.primaryColor,
              padding: EdgeInsets.all(32),
              child: Text("News App",
                style: AppTheme.sideBarTextStyle.copyWith(color: AppColors.white),
                textAlign: TextAlign.center,)
          ),
          buildDarwerListItem(Icons.list, "Categories", (){
            setState(() {
              body = CategoriesTab(onCategoryClick: onCategoryClick);
              Navigator.pop(context);
            });
          }),
          buildDarwerListItem(Icons.settings,"Settings", (){
            setState(() {
              body = SettingsTab();
              Navigator.pop(context);
            });
          })
        ],
      ),
    );
  }

  Widget buildDarwerListItem(IconData iconData, String title,Function onClick) {
    return InkWell(
      onTap: (){
        onClick();
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
        child: Row(
              children: [
                Icon(iconData,size: 32,),
                SizedBox(width: 8,),
                Text(title,style: TextStyle(fontSize: 24),),
              ],
            ),
      ),
    );
  }

  void onCategoryClick(Category category) {
    setState(() {
      body = TabsList(categoryId: category.backEndId);
    });
  }
}

