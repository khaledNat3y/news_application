import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:news_application/data/repos/news_repo/data_sources/remote_data_source/news_remote_data_source_impl.dart';
import 'package:news_application/data/repos/news_repo/data_sources/remote_data_source/news_remote_data_sources.dart';
import 'package:news_application/data/repos/news_repo/news_repo_impl.dart';
import 'package:news_application/ui/screens/home/tabs/home_screen.dart';
import 'package:news_application/ui/screens/home/tabs/search/search_screen.dart';
import 'package:news_application/ui/splash/splash_screen.dart';
import 'package:news_application/utils/app_theme.dart';
import 'package:news_application/utils/firebase_constants.dart';

import 'di.dart';
import 'model/source_response.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await Firebase.initializeApp(
    options: const FirebaseOptions(apiKey:  FirebaseConstants.firebaseApikey,
        appId: FirebaseConstants.firebaseProjectId,
        messagingSenderId: FirebaseConstants.firebaseProjectId,
        projectId: FirebaseConstants.firebaseProjectId),
  );
  FirebaseFirestore.instance.settings =
  const Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  FirebaseFirestore.instance.disableNetwork();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key,});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routes: {
        SplashScreen.routeName: (_) => SplashScreen(),
        Home.routeName: (_) => Home(),
      },
      initialRoute: SplashScreen.routeName,
    );
  }
}

