import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_reward_claim/Utility/SocialAuth.dart';
import 'package:flutter_reward_claim/screens/LoginScreen.dart';
import 'package:flutter_reward_claim/screens/OfferDetailScreen.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  String email;

  HomeScreen({this.email});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  SocialProfile socialProfile =SocialProfile();
  String reg_pass;
  String email;
  var facebookLogin = FacebookLogin();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                CircleAvatar(
                  radius: 30,
                  child: Image.asset("assets/images/user.png"),
                ),
              ],
            )),
            ListTile(
              title: Text("Home"),
              onTap: () {},
            ),
            ListTile(
              title: Text("Profile"),
              onTap: () {},
            ),
            ListTile(
              title: Text("Orders"),
              onTap: () {},
            ),
            ListTile(
              title: Text("About"),
              onTap: () {},
            ),
            ListTile(
              title: Text("Logout"),
              onTap: () {
                setState(() {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
                });

              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text(
          'ƠƑƑЄƦ ƲƤ',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black26,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
            child: ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: 1,
                itemBuilder: (BuildContext context,int index){
                  return detailView();
            }),
            ),
          ],
        ),
      ),
    );
  }
  detailView() {
    return Container(
      margin: EdgeInsets.only(top: 10, right: 10, left: 10),
      height: 130,
      width: MediaQuery.of(context).size.width*1.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        color: Colors.black,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 15,
          ),
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey,
            ),
            child: Image.asset("assets/images/img2.jpg",fit: BoxFit.cover,),
          ),
          SizedBox(
            width: 15,
          ),
          Column(
            children: [
              SizedBox(height: 40,),
              Text("ORDER NOW",style: TextStyle(color: Colors.white),),
              ButtonBar(
                alignment: MainAxisAlignment.start,
                children: [
                  OutlinedButton(
                    onPressed: (){
                      setState(() {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => OfferDetailsScreen()));
                      });
                      },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0))),
                    ),
                    child: Text("View offer details",style: TextStyle(color: Colors.black),),
                  )
                ],
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
