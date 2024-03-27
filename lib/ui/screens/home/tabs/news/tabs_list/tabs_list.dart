import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:news_application/data/repos/news_repo/data_sources/local_data_source/news_local_data_source.dart';
import 'package:news_application/data/repos/news_repo/data_sources/remote_data_source/news_remote_data_sources.dart';
import 'package:news_application/data/repos/news_repo/news_repo_impl.dart';

// import 'package:news_application/data/news_repo/data_sources/remote_data_sources/news_remote_data_sources.dart';
import 'package:news_application/ui/screens/home/tabs/news/tab_details/tab_details.dart';
import 'package:news_application/ui/screens/home/tabs/news/tabs_list_view_moder.dart';
import 'package:news_application/utils/app_colors.dart';
import 'package:news_application/utils/app_theme.dart';
import 'package:provider/provider.dart';

import '../../../../../../data/repos/news_repo/data_sources/local_data_source/news_loacal_data_source_impl.dart';
import '../../../../../../data/repos/news_repo/data_sources/remote_data_source/news_remote_data_source_impl.dart';
import '../../../../../../model/source_response.dart';
import '../../../../../widgets/app_error.dart';
import '../../../../../widgets/app_loader.dart';

class TabsList extends StatefulWidget {
  final String categoryId;

  const TabsList({super.key, required this.categoryId});

  @override
  State<TabsList> createState() => _TabsListState();
}

class _TabsListState extends State<TabsList> {
  int currentTabIndex = 0;
  TabsListViewModel viewModel = TabsListViewModel(
      NewsRepoImpl(
        NewsRemoteDataSourceImpl(),
        NewsLocalDataSourceImpl(),
        InternetConnectionChecker(),

      ));

  @override
  void initState() {
    super.initState();
    viewModel.loadTabsList(widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabsListViewModel,TabsListState>(
      bloc: viewModel,
      builder: (context, state) {
        viewModel = BlocProvider.of(context);
        if (state.listApiState == ApiState.loading) {
          return AppLoader();
        } else if (state == ApiState.success) {
          return tabsList(state.sources);
        } else {
          return ErrorView(
            error: state.errorMessage,
            onRefreshClick: () {
              viewModel.loadTabsList(widget.categoryId);
            },
          );
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
              return tabWidget(
                  source, currentTabIndex == sources.indexOf(source));
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
              children: sources
                  .map((source) => TabDetails(
                        sourceId: source.id!,
                      ))
                  .toList(),
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
        color: isSelected ? AppColors.primaryColor : AppColors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: AppColors.primaryColor),
      ),
      child: Text(
        source.name ?? "",
        style: AppTheme.tabBarTextStyle.copyWith(
          color: isSelected ? AppColors.white : AppColors.primaryColor,
        ),
      ),
    );
  }
}
