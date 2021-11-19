import 'package:flutter/material.dart';
import 'package:flutter_reward_claim/SignupPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30,),
            OfferButton(),
            OfferButton(),
            OfferButton(),
            SizedBox(
              height: 150,
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage()));
            //     },
            //   child: Text("LogOut"),
            // ),
          ],
        ),
      ),
    );
  }
  OfferButton(){
    return Container(
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            ListTile(
              title: const Text('Food Item'),
              subtitle: Text(
                'Description',
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),
           Image.asset('assets/images/img2.jpg',height: 200,width: 400,fit: BoxFit.cover,),
            ButtonBar(
              alignment: MainAxisAlignment.start,
              children: [
                OutlinedButton(
                  onPressed: (){},
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
                  ),
                  child: Text("GET 50% off"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
