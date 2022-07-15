import 'dart:async';

import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:moot/screens/homepage/admin/homeAdmin.dart';
import 'package:moot/screens/homepage/user/homeUser.dart';
import 'package:moot/screens/onboarding/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class SplashFuturePage extends StatefulWidget {
  const SplashFuturePage({Key? key}) : super(key: key);

  @override
  _SplashFuturePageState createState() => _SplashFuturePageState();
}

class _SplashFuturePageState extends State<SplashFuturePage> {
  Future<Widget> futureCall() async {
    await Future.delayed(Duration(seconds: 3), () {
      print(" This line is execute after 3 seconds");
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('token')) {
      if (prefs.getString('role') == 'admin') {
        return Future.value(HomePageAdmin());
      } else {
        return Future.value(HomeUser());
      }
    }
    return Future.value(const OnBoardingPage());
  }

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset(
        'assets/images/logo.png',
      ),
      logoSize: 90,
      backgroundColor: Colors.white,
      showLoader: true,
      loaderColor: const Color(0xff4C74D9),
      futureNavigator: futureCall(),
    );
  }
}
