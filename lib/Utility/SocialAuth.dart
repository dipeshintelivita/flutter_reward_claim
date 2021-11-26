import 'dart:async';
import 'dart:convert';

import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_reward_claim/Utility/Constant.dart';
import 'package:flutter_reward_claim/screens/LoginScreen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class SocialAuth {
  // final FirebaseAuth _auth = FirebaseAuth.instance;st
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  LoginScreen login = LoginScreen();
  var isLoggedIn = false;
  Future<SocialProfile> signInWithFacebook() async {
    final facebookLogin = FacebookLogin();
    await facebookLogin.logOut();
    final result = await facebookLogin
        .logInWithReadPermissions(["email", "public_profile"]);
    print("Result is: ${result.status}");
    if (result.status == FacebookLoginStatus.cancelledByUser) {
      return SocialProfile.withError("cancelled");
    }
    if (result.status == FacebookLoginStatus.error) {
      if (result.status == FacebookLoginStatus.loggedIn) {
        FacebookAccessToken myToken = result.accessToken;
        // AuthCredential credential
        // FacebookAuthProvider.credential(myToken.token);
        // var user = await FirebaseAuth.instance.signInWithCredential(credential);
        // print(user);
      }
      if (result.errorMessage.contains("CONNECTION_FAILURE")) {
        return SocialProfile.withError(
            "Internet connection not available, check your connection and try again");
      } else if (result.errorMessage.contains("INTERNET_DISCONNECTED")) {
        return SocialProfile.withError(
            "Internet connection not available, check your connection and try again");
      }
    }
    return getFacebookProfileFor(result);
  }

  Future<SocialProfile> getFacebookProfileFor(
      FacebookLoginResult result) async {
    // var completer = Completer<SocialProfile>();
    var url =
        'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.type(large)&access_token=${result.accessToken.token}';
    var response = await http.get(Uri.parse(url)).catchError((error) {
      // ignore: return_of_invalid_type_from_catch_error
      return SocialProfile.withError(error.toString());
    });

    var jsonData = json.decode(response.body);
    print("Json Data $jsonData");
    var profile = SocialProfile.facebook(jsonData);
    return profile;
  }

  // return completer.future;

  Future<SocialProfile> signInWithGoogle() async {
    var completer = Completer<SocialProfile>();

    _googleSignIn.signIn().then((account) {
      if (account != null) {
        var profile = SocialProfile.google(account);
        completer.complete(profile);
      } else {
        var profile = SocialProfile.withError("cancelled");
        completer.complete(profile);
      }
    }).catchError((err) {
      if (err.toString().contains("network_error")) {
        var profile = SocialProfile.withError(
            "Internet connection not available, check your connection and try again");
        completer.complete(profile);
      } else {
        var profile = SocialProfile.withError(err.toString());
        completer.complete(profile);
      }
    });
    return completer.future;
  }
}

class SocialProfile {
  var socialId = "";
  int user_id = 0;
  var full_name = "";
  var first_time = "";
  var phone = "";
  var firstName = "";
  var lastName = "";
  var name = "";
  var email = "";
  var token = "";
  var profilePicture = "";

  var type = "";
  dynamic error;

  SocialProfile();

  SocialProfile.fromJson(Map<String, dynamic> json) {
    socialId = Constant.getStringFromMap(json, "socialId");
    full_name = Constant.getStringFromMap(json, "full_name");
    user_id = Constant.getIntFromMap(json, "user_id");
    first_time = Constant.getStringFromMap(json, "first_time");
    phone = Constant.getStringFromMap(json, "phone");
    firstName = Constant.getStringFromMap(json, "firstName");
    lastName = Constant.getStringFromMap(json, "lastName");
    name = Constant.getStringFromMap(json, "name");
    email = Constant.getStringFromMap(json, "email");
    token = Constant.getStringFromMap(json, "token");
    profilePicture = Constant.getStringFromMap(json, "profilePicture");
    type = Constant.getStringFromMap(json, "type");
  }

  SocialProfile.facebook(Map<String, dynamic> json) {
    firstName = json['first_name'] as String;
    lastName = json['last_name'] as String;
    name = json["name"] as String;
    email = json["email"] as String;
    socialId = json["id"] as String;
    profilePicture = json["picture"]["data"]["url"] as String;
    type = "facebook";
  }

  SocialProfile.withError(String error) {
    this.error = error;
  }

  SocialProfile.google(GoogleSignInAccount account) {
    name = account.displayName;
    var splitname = name.split(' ');
    firstName = splitname.isNotEmpty ? splitname[0] : "";
    lastName = splitname.length > 1 ? splitname[1] : "";
    socialId = account.id;
    email = account.email;
    profilePicture = account.photoUrl;
    type = 'google';
  }
}
