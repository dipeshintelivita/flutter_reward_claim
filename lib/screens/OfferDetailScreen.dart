import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OfferDetailsScreen extends StatefulWidget {
  @override
  _OfferDetailsScreenState createState() => _OfferDetailsScreenState();
}

class _OfferDetailsScreenState extends State<OfferDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Container(
          // height: MediaQuery.of(context).size.height*1,
          child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 150,
            ),
            ListView.builder(
                //physics: BouncingScrollPhysics() ,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return conditions();
                }),
            SizedBox(
              height: 100,
            ),
            GestureDetector(
              onTap: ()async{
                var url = 'https://www.instagram.com/';

                if (await canLaunch(url)) {
                  await launch(
                    url,
                    universalLinksOnly: true,
                  );
                } else {
                  throw 'There was a problem to open the url: $url';
                }
              },
              child:Image.asset("assets/icon/instalogo.png",
              height: 80,
              width: 80,
              ),
            )
          ],
        ),
      )),
    );
  }

  conditions() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 30,
          ),
          Text(
            "•Please tag our 'InstagramId' into your post.\n\n•Coupon code can be applied only once \n  per user.\n\n•Other T&C may apply.",
            style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
