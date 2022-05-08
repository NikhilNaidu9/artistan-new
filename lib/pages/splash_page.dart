import 'package:artistan/pages/auth/signup_page.dart';
import 'package:artistan/pages/auth/login_page.dart';
import 'package:flutter/material.dart';

import 'package:artistan/resources/values/app_colors.dart';

import 'dart:async';

// Splash Page Needed
class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Material(
        color: AppColors.PRIMARY_COLOR_DARK,
        child: Center(
          child: Text(
            "Artistan",
            style: TextStyle(
                fontSize: 54.0,
                fontFamily: 'Black_And_White_Picture',
                color: AppColors.PRIMARY_COLOR),
          ),
        ),
      ),
    );
  }
}
