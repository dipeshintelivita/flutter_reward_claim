import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reward_claim/screens/HomeScreen.dart';
import 'package:flutter_reward_claim/screens/LoginScreen.dart';
import 'package:flutter_reward_claim/screens/SignupScreen.dart';
import 'package:flutter_reward_claim/screens/SplashScreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}