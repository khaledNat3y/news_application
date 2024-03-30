import 'package:flutter/material.dart';
import 'package:news_application/utils/app_theme.dart';

import '../../../../../utils/app_colors.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  static const String arabicValue = "ar";
  static const String EnglishValue = "en";
  String selectedLanguage = EnglishValue;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: EdgeInsets.all(10),
            child: Text("Language",style: AppTheme.titleStyle,)),
        Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            border: Border.all(width: 1,color: AppColors.primaryColor)
          ),
          child: DropdownButton(
            underline: SizedBox(),
            isExpanded: true,
            value: selectedLanguage,
            items: [
              DropdownMenuItem(
                value: EnglishValue,
                child: Text("English"),
              ),
              DropdownMenuItem(
                value: arabicValue,
                child: Text("العربية"),
              ),
            ],
            onChanged: (String? newValue) {
              if(newValue == null) return;
              selectedLanguage = newValue;
              setState(() {});
            },
          ),
        ),
      ],
    );
  }
}
