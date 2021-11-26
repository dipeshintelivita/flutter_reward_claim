import 'package:flutter/material.dart';
import 'package:flutter_reward_claim/Utility/HexColor.dart';
import 'package:flutter_reward_claim/Utility/SocialAuth.dart';
import 'package:flutter_reward_claim/Utility/shared_preferences_helper.dart';
import 'package:flutter_reward_claim/screens/HomeScreen.dart';
import 'package:flutter_reward_claim/screens/SignupScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';


// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {

  String email, pass, name;

  LoginScreen({this.email, this.pass, this.name});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {

  String _message = 'Log in/out by pressing the buttons below.';
  SocialAuth socialAuth= SocialAuth();
  String hintText = 'Hello , iam Hint';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _name = TextEditingController();
  // ignore: non_constant_identifier_names
  var reg_email;
  // ignore: non_constant_identifier_names
  var reg_pass;
  var isLoggedIn = false;

  void setStringInPreference() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString('name', _name.toString());
  }

  validator() {
    if (_formKey.currentState != null && _formKey.currentState.validate()) {
      MySharedPreferences.instance.setStringValue("email", _email.text.toString());
      MySharedPreferences.instance.setStringValue("password", _pass.text.toString());

      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SignupScreen()));
    } else {
      print("not validated");
    }
  }

  bool changeButton = false;
  bool validateUsername = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MySharedPreferences.instance
        .getStringValue("email")
        .then((value) => setState(() {
      reg_email = value;
    }));
    MySharedPreferences.instance
        .getStringValue("password")
        .then((value) => setState(() {
      reg_pass = value;
    }));

  }
  void onLoginStatusChanged(bool isLoggedIn) {
    this.isLoggedIn = isLoggedIn;
    if(isLoggedIn==true){
      setState(() {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
      });
    }
    else{
      setState(()
      {
        CircularProgressIndicator();
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor("404e6b"),
        body: GestureDetector(
          onTap: (){
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


  // ignore: missing_return


  void _showMessage(String message) {
    setState(() {
      _message = message;
    });
  }

  detailsView() {
    return Container(
      height: MediaQuery.of(context).size.height*1.0,
      width: MediaQuery.of(context).size.width*1.0,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20,),
            Image.asset(
              "assets/icon/logo.png",
              height: 150,
              width: 150,
            ),
            SizedBox(height: 20,),
            Stack(
              children: [
              Container(
                    decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)
                ),
                height: 250,
                width: 300,
                child:Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height:10,),
                      TextFormField(
                        controller: _email,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          isCollapsed: true,
                          contentPadding: EdgeInsets.only(top: 1),
                          prefixIcon:Padding(
                            padding: const EdgeInsets.only(top: 1),
                            child: Icon(
                              Icons.email_outlined,
                              color: Colors.black,
                            ),
                          ),
                          hintText: "Enter Email",
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          hintStyle: TextStyle(color: Colors.black),
                          labelText: " E m a i l",
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
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
                          widget.email = value;
                          setState(() {});
                        },
                      ),
                      TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        controller: _pass,
                        decoration: InputDecoration(
                          isCollapsed: true,
                          contentPadding: EdgeInsets.only(top:3),
                          prefixIcon:Padding(padding: const EdgeInsets.only(top: 0),
                            child: Icon(
                              Icons.lock,
                              color: Colors.black,
                            ),
                          ),
                          hintText: "Enter password",
                          hintStyle: TextStyle(color: Colors.black),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          labelText: " P a s s w o r d",
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
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
                         widget.pass = value;
                          setState(() {});
                        },
                      ),
                      SizedBox(height:40,),
                      SizedBox(
                        height: 40,
                        width: 250,
                        child: ElevatedButton(
                          onPressed: () async {
                            await _loginMethod();
                            print(_loginMethod());
                          },
                          child: const Text(
                            "L  O  G  I  N",
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
            SizedBox(height: 10,),
            Text(
              "Not have an account?" ,
              style: TextStyle(color: Colors.white),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: HexColor("20a173"),
                elevation: 15,
              ),
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignupScreen()));
              },
              child: const Text(
                "Register",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Text("━━━━━━━━━OR━━━━━━━━━",style: TextStyle(color: Colors.white),),
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: ()  async{
                      // socialAuth.signInWithFacebook();
                      var details = await socialAuth.signInWithFacebook();
                      if(details.user_id!=null)
                      setState(() {
                        onLoginStatusChanged(true);
                      });
                      },
                    child: Container(
                      height: 40,
                      width: 100,
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
                    thickness: .5,
                  ),
                  GestureDetector(
                    onTap: () async{
                      var details = await socialAuth.signInWithGoogle();
                      if(details.user_id!=null)
                        setState(() {
                          onLoginStatusChanged(true);
                        });
                    },
                    child: Container(
                        height: 40,
                        width: 100,
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
            )
          ]
      ),
    );
  }
  Future _loginMethod() {
    if (_formKey.currentState.validate()) {
      if (reg_email == _email.text.toString() &&
          reg_pass == _pass.text.toString()) {
        isLoggedIn = !isLoggedIn;
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => HomeScreen(
              email: reg_email,
            )));
      }
    } else {
      print("Please Enter Valid Email & Password");
    }
  }
}
