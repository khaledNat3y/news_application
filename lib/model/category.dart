import 'dart:ui';

import 'package:news_application/utils/app_colors.dart';

class Category {
  String backEndId;
  String title;
  String imagePath;
  bool isLeftSided;
  Color backgroundColor;
  Category({
    required this.backEndId,
    required this.title,
    required this.imagePath,
    required this.isLeftSided,
    required this.backgroundColor
  });
  static List<Category> categories = [
    Category(backEndId: "sports", title: "Sports",
        imagePath: "assets/sports.png",
        isLeftSided: true,
        backgroundColor: AppColors.sportBackground),

    Category(backEndId: "technology", title: "Technology",
        imagePath: "assets/Politics.png",
        isLeftSided: false,
        backgroundColor: AppColors.politicsBackground),

    Category(backEndId: "health", title: "Health",
        imagePath: "assets/health.png",
        isLeftSided: true,
        backgroundColor: AppColors.healthBackground),

    Category(backEndId: "business", title: "Business",
        imagePath: "assets/bussines.png",
        isLeftSided: false,
        backgroundColor: AppColors.businessBackground),

    Category(backEndId: "entertainment", title: "Entertainment",
        imagePath: "assets/environment.png",
        isLeftSided: true,
        backgroundColor: AppColors.enviromentBackground),

    Category(backEndId: "science", title: "Science",
        imagePath: "assets/science.png",
        isLeftSided: false,
        backgroundColor: AppColors.scienceBackground),
  ];
}