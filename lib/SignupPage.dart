import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_reward_claim/HomePage.dart';
import 'package:flutter_reward_claim/UserDataModel.dart';
import 'package:http/http.dart' as http;

class SignupPage extends StatefulWidget {

String user_Id;
  @override
  _SignupPageState createState() => _SignupPageState();
}


class _SignupPageState extends State<SignupPage> {
  String _message = 'Log in/out by pressing the buttons below.';
  bool isLoggedIn = false;

  void onLoginStatusChanged(bool isLoggedIn) {
    this.isLoggedIn = isLoggedIn;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Facebook Login"),
        ),
        body: Container(
          child: Center(
            child: isLoggedIn
                ? Navigator.push(context,MaterialPageRoute(builder: (context)=>HomePage()))
                : RaisedButton(
                    elevation: 5,
                    color: Colors.blue,
                    child: Text(
                      "Login with Facebook",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      initiateFacebookLogin();
                    }),
          ),
        ),
      ),
    );
  }

  void initiateFacebookLogin() async {
   var facebookLogin = FacebookLogin();
    await facebookLogin.logOut();
    final FacebookLoginResult result =
        await facebookLogin.logInWithReadPermissions(['email','public_profile']);
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
    Future<UserData> getFacebookProfileFor(
        FacebookLoginResult result) async {
      // var completer = Completer<SocialProfile>();

      var url ='https://graph.facebook.com/v12.0/me?fields=name,first_name,last_name,email,picture.type(large)&access_token=${result.accessToken.token}';
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
}
