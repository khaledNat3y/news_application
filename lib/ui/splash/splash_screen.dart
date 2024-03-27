import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_application/ui/screens/home/tabs/home_screen.dart';

class SplashScreen extends StatefulWidget {
  static const routeName="splash";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    Future.delayed(Duration(seconds: 2),() {
      Navigator.of(context).pushReplacementNamed(Home.routeName);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Image.asset("assets/splash.png"),
    );
  }
}
