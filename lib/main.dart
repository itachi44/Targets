import 'package:flutter/material.dart';
//import 'package:flutter_maps/firetester.dart';
import './screens/passWord_recovery.dart';
import './screens/getting_started_screen.dart';
import './screens/login_screen.dart';
import './screens/signup_screen.dart';
import 'splashScreen.dart' as sc;
import 'mapper.dart' as map;
import 'package:flutter/services.dart';
import './page_principale.dart';
import './background_location.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
   .then((_) {
     runApp(MaterialApp(
  title: "My App",
  home: sc.Splash(),
));
  });
}

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
      home:BgLocation(),//GettingStartedScreen(),
      routes: {
        LoginScreen.routeName: (ctx) => LoginScreen(),
        SignupScreen.routeName: (ctx) => SignupScreen(),
        ForgetPasswordPage.routeName: (ctx) => ForgetPasswordPage(),
        map.MyHomePage.routeName : (ctx) => map.MyHomePage(title: "Ma Carte",),
      },
    );
  }
}
