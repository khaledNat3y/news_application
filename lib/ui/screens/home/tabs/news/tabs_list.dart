import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:news_application/data/api_manager.dart';
import 'package:news_application/ui/screens/home/tabs/news/tab_details.dart';
import 'package:news_application/utils/app_colors.dart';
import 'package:news_application/utils/app_theme.dart';

import '../../../../../model/source_response.dart';
import '../../../../widgets/app_error.dart';
import '../../../../widgets/app_loader.dart';
class TabsList extends StatefulWidget {
  final String categoryId;
  const TabsList({super.key, required this.categoryId});

  @override
  State<TabsList> createState() => _TabsListState();
}

class _TabsListState extends State<TabsList> {
  final bool isSelected = true;
  int currentTabIndex = 0;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ApiManager.loadTabsList(widget.categoryId),
        builder: (context,snapshot) {
          if(snapshot.hasError) {
            return ErrorView(error: snapshot.error.toString());
          }else if(snapshot.hasData) {
            return tabsList(snapshot.data!.sources!);
          }else {
            return AppLoader();
          }
        },
    );
  }

  Widget tabsList(List<Source> sources) {
    List<Widget> tabsWidgetList = [];
    // for(var source in sources) {
    //   tabsWidgetList.add(tabWidget(source, true));
    // }
    return DefaultTabController(
      length: sources.length,
      child: Column(
        children: [
          TabBar(
            tabs: sources.map((source) {
              return tabWidget(source, currentTabIndex ==
                  sources.indexOf(source));
            }).toList(),
            isScrollable: true,
            indicatorColor: Colors.transparent,
            onTap: (newTabIndex) {
              currentTabIndex = newTabIndex;
              setState(() {});
            },
          ),
          Expanded(
            child: TabBarView(
              children: sources.map((source) => TabDetails(sourceId: source.id!,)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget tabWidget(Source source, bool isSelected) {
    return Container(
      alignment: AlignmentDirectional.topStart,
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: isSelected? AppColors.primaryColor : AppColors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: AppColors.primaryColor),
      ),
      child: Text(source.name ?? "",
        style: AppTheme.tabBarTextStyle.
        copyWith(color: isSelected? AppColors.white : AppColors.primaryColor,),
      ),
    );
  }
}





