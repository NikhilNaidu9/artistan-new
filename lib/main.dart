import 'package:artistan/pages/auth/login_page.dart';
import 'package:artistan/pages/auth/signup_page.dart';
import 'package:artistan/pages/dashboard/dashboard.dart';
import 'package:artistan/pages/profile/contact_info.dart';
import 'package:artistan/pages/profile/hourly_rate_info.dart';
import 'package:artistan/pages/profile/personal_info.dart';
import 'package:artistan/pages/profile/profile_page_one.dart';
import 'package:artistan/pages/profile/profile_pic_upload.dart';
import 'package:artistan/pages/profile/user_prompt.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:artistan/resources/values/app_colors.dart';
import 'package:artistan/pages/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
      theme: ThemeData(
          primaryColor: AppColors.PRIMARY_COLOR_DARK,
          primaryColorLight: AppColors.PRIMARY_COLOR_LIGHT,
          primaryColorDark: AppColors.PRIMARY_COLOR_DARK,
          accentColor: AppColors.ACCENT_COLOR,
          cursorColor: AppColors.PRIMARY_COLOR_DARK,
          fontFamily: 'Open_Sans'),
    );
  }
}
