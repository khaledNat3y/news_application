import 'package:flutter/material.dart';
import 'package:news_application/model/category.dart';

import '../../../../../utils/app_colors.dart';

class AppCategory extends StatelessWidget {
  final Category category;
  const AppCategory({super.key, required this.category});
  final raduis = const Radius.circular(24);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: category.backgroundColor,
        borderRadius: BorderRadius.only(
          topRight: raduis,
          topLeft: raduis,
          bottomLeft: category.isLeftSided ? Radius.zero : raduis,
          bottomRight: category.isLeftSided ? raduis : Radius.zero,
        )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(category.imagePath, height: MediaQuery.sizeOf(context).height * 0.15,),
          Text(category.title, style: TextStyle(color: AppColors.white),)
        ],
      ),
    );
  }
}
