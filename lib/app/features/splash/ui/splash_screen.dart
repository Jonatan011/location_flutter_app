import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:location_flutter_app/app/shared/config/router/app_navigator.dart';
import 'package:location_flutter_app/app/shared/design_system/color_palette.dart';
import 'package:location_flutter_app/app/shared/design_system/styles.dart';
import 'package:location_flutter_app/app/shared/utils/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), _navigateToNextScreen);
  }

  void _navigateToNextScreen() {
    goToLocation(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              lightBlue,
              blue,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icono
              Icon(
                Icons.location_on,
                size: splashIconStyle.size,
                color: splashIconStyle.color,
              ),
              SizedBox(height: 20.h),
              // Título
              Text(
                tr(kSplashTitle),
                style: splashTitleStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
