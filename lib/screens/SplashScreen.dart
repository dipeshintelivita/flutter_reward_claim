



import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reward_claim/Utility/HexColor.dart';
import 'package:flutter_reward_claim/Utility/shared_preferences_helper.dart';
import 'package:flutter_reward_claim/screens/HomeScreen.dart';
import 'package:flutter_reward_claim/screens/LoginScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  var isLoggedIn=false;

  @override
  void initState(){
    PrefUtils.saveInitialScreenState(true);
    super.initState();
    Timer(Duration(seconds: 2), () async {
      var isFirstTime = await PrefUtils.getValueFor(PrefUtils.isFirstTime);

      if (isFirstTime != null && isFirstTime == true) {

        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(
            builder: (context) => LoginScreen()));
      } else if (isFirstTime == null) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(
            builder: (context) => SplashScreen()));
      } else {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(
            builder: (context) => HomeScreen()));    }
    });
  }


  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        duration: 1000,
        splash:'assets/icon/SplashLogo.png',
        nextScreen: LoginScreen(),
        splashTransition: SplashTransition.rotationTransition,
        backgroundColor: HexColor("404e6b"),
      ),
    );
  }
}
