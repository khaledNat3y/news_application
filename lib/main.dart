import 'package:flutter/material.dart';
import 'package:news_application/ui/screens/home/tabs/home_screen.dart';
import 'package:news_application/utils/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      routes: {

        Home.routeName: (_) => Home(),
      },
      initialRoute: Home.routeName,
    );
  }
}

