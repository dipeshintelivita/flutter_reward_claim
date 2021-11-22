// ignore: must_be_immutable
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_reward_claim/Utility/HexColor.dart';
import 'package:flutter_reward_claim/Utility/UserDataModel.dart';
import 'package:flutter_reward_claim/screens/HomeScreen.dart';
import 'package:http/http.dart' as http;

class SignupScreen extends StatefulWidget {
// ignore: non_constant_identifier_names
  String user_Id;
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupScreen> {
  String _message = 'Log in/out by pressing the buttons below.';
  bool isLoggedIn = false;

  void onLoginStatusChanged(bool isLoggedIn) {
    this.isLoggedIn = isLoggedIn;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("404e6b"),
      // appBar: AppBar(
      //   title: const Text(
      //     'ƠƑƑЄƦ ƲƤ',
      //     style: TextStyle(
      //       color: Colors.black,
      //     ),
      //   ),
      //   centerTitle: true,
      //   backgroundColor: Colors.black26,
      //   elevation: 0.0,
      //   automaticallyImplyLeading: false,
      // ),
      body: detailsView(),
    );
  }

  void initiateFacebookLogin() async {
    var facebookLogin = FacebookLogin();
    await facebookLogin.logOut();
    final FacebookLoginResult result = await facebookLogin
        .logInWithReadPermissions(['email', 'public_profile']);
    switch (result.status) {
      case FacebookLoginStatus.error:
        print("Error");
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("CancelledByUser");
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        print("LoggedIn");
        onLoginStatusChanged(true);
        _showMessage('''
         Logged in!
         
         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}
         ''');
        print(accessToken.userId);
        print(accessToken.token);
        break;
    }
    Future<UserData> getFacebookProfileFor(FacebookLoginResult result) async {
      // var completer = Completer<SocialProfile>();

      var url =
          'https://graph.facebook.com/v12.0/me?fields=name,first_name,last_name,email,picture.type(large)&access_token=${result.accessToken.token}';
      var response = await http.get(Uri.parse(url)).catchError((error) {
        // ignore: return_of_invalid_type_from_catch_error
        return UserData.withError(error.toString());
      });

      var jsonData = json.decode(response.body);
      print("Json Data $jsonData");
      var profile = UserData.facebook(jsonData);
      return profile;
    }
  }

  void _showMessage(String message) {
    setState(() {
      _message = message;
    });
  }

  detailsView() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Image.asset(
            "assets/icon/logo.png",
            height: 150,
            width: 150,
          )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 32.0),
            child: Form(
              child: Column(
                children: [
                  TextFormField(
                   // controller: _email,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.email_outlined,color: Colors.white,),
                      hintText: "Enter Email",
                      hintStyle: TextStyle(color: Colors.white),
                      labelText: "email",
                      labelStyle: TextStyle(color: Colors.white,),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                    ),
                    style: TextStyle(color: Colors.white,),
                    cursorColor: Colors.white,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "field is required";
                      }
                      return null;
                    },
                    // onChanged: (value) {
                    //   name = value;
                    //   setState(() {});
                    // },
                  ),
                  TextFormField(
                    // controller: _email,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.lock,color: Colors.white,),
                      hintText: "Enter Password",
                      hintStyle: TextStyle(color: Colors.white),
                      labelText: "Password",
                      labelStyle: TextStyle(color: Colors.white,),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                    ),
                    style: TextStyle(color: Colors.white,),
                    cursorColor: Colors.white,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "field is required";
                      }
                      return null;
                    },
                    // onChanged: (value) {
                    //   name = value;
                    //   setState(() {});
                    // },
                  ),
                  // TextFormField(
                  //  // controller: _pass,
                  //   obscureText: true,
                  //   decoration: const InputDecoration(
                  //     icon: Icon(Icons.lock_outlined),
                  //     hintText: "Enter Password",
                  //     labelText: "password",
                  //   ),
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return "field is required";
                  //     }
                  //     return null;
                  //   },
                  // ),


                ],
              ),
            ),
          ),
          SizedBox(
            height: 150,
          ),
          isLoggedIn
              ? myfunction()
              : GestureDetector(
                  onTap: () {
                    initiateFacebookLogin();
                  },
                  child: Container(
                      height: 40,
                      width: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.blueAccent),
                      child:
                          Center(
                            child: Text( "facebook",style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                  ),


          ),
          SizedBox(height: 10,),
          GestureDetector(
            onTap: () {
              initiateFacebookLogin();
            },
            child: Container(
                height: 40,
                width: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8), color: Colors.red),
                child: Center(
                  child: Text(
                    "Google",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                )),
          ),
        ],
      ),
    );
  }

  Future<Widget> myfunction() {
    Future.delayed(Duration(seconds: 1), () async {
      await Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }
}
