import 'package:flutter/material.dart';
import 'package:news_application/model/category.dart';
import 'package:news_application/ui/screens/home/tabs/categories/app_category_widget.dart';

import '../../../../../utils/app_theme.dart';

class CategoriesTab extends StatelessWidget {
  final void Function(Category) onCategoryClick;

  const CategoriesTab({super.key, required this.onCategoryClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(15),
            child: Text(
              "pick you category \n of interest",
              style: AppTheme.sideBarTextStyle
                  .copyWith(color: const Color(0xff4F5A69)),
            ),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: Category.categories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      onCategoryClick(Category.categories[index]);
                    },
                    child: AppCategory(category: Category.categories[index]));
              },
            ),
          )
        ],
      ),
    );
  }
}
