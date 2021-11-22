import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
            children: [
              DrawerHeader(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                  CircleAvatar(
                    radius: 30,
                    child: Image.asset("assets/images/user.png"),
                  ),
                ],
              )),
              ListTile(title: Text("Home"), onTap: (){},),
              ListTile(title: Text("Profile"), onTap: (){},),
              ListTile(title: Text("Orders"), onTap: (){},),
              ListTile(title: Text("About"), onTap: (){},),
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
            SizedBox(height: 30,),
            detailView(),
            detailView(),
            detailView(),
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
  detailView(){
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
