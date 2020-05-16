import 'package:flutter/material.dart';
import './screens/passWord_recovery.dart';
import './screens/getting_started_screen.dart';
import './screens/login_screen.dart';
import './screens/signup_screen.dart';
import 'splashScreen.dart' as sc;
import 'mapper.dart' as map;


void main() => runApp(MaterialApp(
  title: "My App",
  home: sc.Splash(),
));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GettingStartedScreen(),
      routes: {
        LoginScreen.routeName: (ctx) => LoginScreen(),
        SignupScreen.routeName: (ctx) => SignupScreen(),
        ForgetPasswordPage.routeName: (ctx) => ForgetPasswordPage(),
        map.MyHomePage.routeName : (ctx) => map.MyHomePage(title: "Ma Carte",),
      },
    );
  }
}
