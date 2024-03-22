import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smart_pay/views/onboarding_view.dart';

import '../helpers/colors.dart';
import '../helpers/size_calculator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startSplashScreen() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, () async {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const OnboardingView()));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startSplashScreen();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
          child: Container(
              height: AppConstants.screenHeight(context),
              width: AppConstants.screenWidth(context),
              color: AppColors.whiteColor,
              // color: Colors.blueAccent,

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 150,
                      width: 150,
                      child: Image.asset("assets/icons/logosplash.png")),
                  // Image.asset('images/splash3.png'),



                ],
              ))),
    );
  }
}
