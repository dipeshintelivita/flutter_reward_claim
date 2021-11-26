// ignore: must_be_immutable
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_reward_claim/Utility/HexColor.dart';
import 'package:flutter_reward_claim/Utility/UserDataModel.dart';
import 'package:flutter_reward_claim/Utility/shared_preferences_helper.dart';
import 'package:flutter_reward_claim/screens/HomeScreen.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class SignupScreen extends StatefulWidget {
// ignore: non_constant_identifier_names
  String user_Id;
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  String _message = 'Log in/out by pressing the buttons below.';
  bool isLoggedIn = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void onLoginStatusChanged(bool isLoggedIn) {
    this.isLoggedIn = isLoggedIn;
    setState(() {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }

  validator() {
    if (_formKey.currentState != null && _formKey.currentState.validate()) {
      MySharedPreferences.instance
          .setStringValue("email", _email.text.toString());
      MySharedPreferences.instance
          .setStringValue("password", _pass.text.toString());

      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => SignupScreen()));
    } else {
      print("not validated");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor("404e6b"),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            new TextEditingController().clear();
          },
          child: Container(
            child: SingleChildScrollView(
              child: detailsView(),
            ),
          ),
        ));
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
      height: MediaQuery.of(context).size.height*1.0,
      width: MediaQuery.of(context).size.width*1.0,
      child: IntrinsicWidth(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/icon/logo.png",
                height: 130,
                width: 130,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 32.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          height: 350,
                          width: 300,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 24.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextFormField(
                                  controller: _email,
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: InputDecoration(
                                    isCollapsed: true,
                                    contentPadding: EdgeInsets.only(top: 1),
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.only(top: 1),
                                      child: Icon(
                                        Icons.email_outlined,
                                        color: Colors.black,
                                      ),
                                    ),
                                    hintText: "Enter Email",
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    hintStyle: TextStyle(color: Colors.black),
                                    labelText: " E m a i l",
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                  ),

                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  cursorColor: Colors.black,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "field is required";
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                   // name = value;
                                    setState(() {});
                                  },
                                ),
                                TextFormField(
                                  textAlignVertical: TextAlignVertical.center,
                                  controller: _name,
                                 decoration: InputDecoration(
                                    isCollapsed: true,
                                    contentPadding: EdgeInsets.only(top: 3),
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.only(top: 0),
                                      child: Icon(
                                        Icons.person_sharp,
                                        color: Colors.black,
                                      ),
                                    ),
                                    hintText: "Enter username",
                                    hintStyle: TextStyle(color: Colors.black),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    labelText: " U s e r n a m e",
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                  ),
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  cursorColor: Colors.black,
                                  // validator: (value) {
                                  //   if (value == null || value.isEmpty) {
                                  //     return "field is required";
                                  //   }
                                  //   return null;
                                  // },
                                  // onChanged: (value) {
                                  //  // name = value;
                                  //   setState(() {});
                                  // },
                                ),
                                TextFormField(
                                  textAlignVertical: TextAlignVertical.center,
                                  controller: _pass,
                                decoration: InputDecoration(
                                    isCollapsed: true,
                                    contentPadding: EdgeInsets.only(top: 3),
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.only(top: 0),
                                      child: Icon(
                                        Icons.lock_open_outlined,
                                        color: Colors.black,
                                      ),
                                    ),
                                    hintText: "Enter password",
                                    hintStyle: TextStyle(color: Colors.black),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    labelText: " P a s s w o r d",
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                  ),
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  cursorColor: Colors.black,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "field is required";
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                   // name = value;
                                    setState(() {});
                                  },
                                ),
                                TextFormField(
                                  textAlignVertical: TextAlignVertical.center,
                                  controller: _confirmPass,
                                 decoration: InputDecoration(
                                    isCollapsed: true,
                                    contentPadding: EdgeInsets.only(top: 3),
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.only(top: 0),
                                      child: Icon(
                                        Icons.lock,
                                        color: Colors.black,
                                      ),
                                    ),
                                    hintText: "Re-Enter password",
                                    hintStyle: TextStyle(color: Colors.black),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    labelText: " P a s s w o r d",
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                  ),
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  cursorColor: Colors.black,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "field is required";
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                   // name = value;
                                    setState(() {});
                                  },
                                ),
                                SizedBox(height: 50,),
                                SizedBox(
                                  height: 40,
                                  width: 230,
                                  child: ElevatedButton(
                                    onPressed: ()  {},
                                    child: const Text(
                                      "S I G N   U P",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    style: ElevatedButton.styleFrom(

                                        primary: Colors.black,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        textStyle: const TextStyle(
                                            fontSize: 15, fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Text(
                "━━━━━━━━ Signup with ━━━━━━━━",
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 5,),
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        initiateFacebookLogin();
                      },
                      child: Container(
                        height: 40,
                        width: 120,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.blueAccent),
                        child: Center(
                          child: Text(
                            "facebook",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    VerticalDivider(
                      color: Colors.white,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                          height: 40,
                          width: 120,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.red),
                          child: Center(
                            child: Text(
                              "Google",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          )),
                    ),
                  ],
                ),
              )
            ]),
      ),
    );
  }

  // Future<Widget> myfunction() {
  //   Future.delayed(Duration(seconds: 1), () async {
  //     await Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => HomeScreen()));
  //   });
  // }
}
