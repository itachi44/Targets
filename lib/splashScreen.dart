import 'package:shared_preferences/shared_preferences.dart';
import "package:splashscreen/splashscreen.dart";
import 'package:flutter/material.dart';
import 'main.dart' as main;
import 'page_principale.dart' as home;
class Splash extends StatefulWidget {
  @override
  _SplashState createState() => new _SplashState();
}

class _SplashState extends State<Splash> {
  String userId;
  Future<void> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString("userId") ?? null;
    });
  }
  @override
  void initState() {
    super.initState();
    getUserId();
  }

  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      title: new Text(
        'Welcome In SplashScreen',
        style: new TextStyle(fontWeight: FontWeight.bold, 
            fontSize: 20.0),
      ),
      seconds: (userId==null)?6:3,
      navigateAfterSeconds: (userId==null)? main.MyApp(): home.MyApp(userid: userId,),
      image: new Image.asset('assets/loading.gif'),
      backgroundColor: Colors.black,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 150.0,
      onClick: () => print("Flutter Egypt"),
      loaderColor: Colors.white,
    );
  }
}
