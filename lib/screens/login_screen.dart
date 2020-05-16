import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:nice_button/nice_button.dart';
import '../screens/passWord_recovery.dart';
import 'user.dart';
import 'package:flutter_maps/page_principale.dart' as pp;
import 'package:flutter_maps/persist.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_responsive_screen/flutter_responsive_screen.dart';
import 'package:responsive_widgets/responsive_widgets.dart';

var firstColor = Color(0xff5b86e5), secondColor = Color(0xff36d1dc);

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  User user;
  bool connect = true;
  String _tel, _mdp, _message = "";
  var data;

  signIn(tel, mdp) async {
    await Firestore.instance
        .collection("User")
        .where("tel", isEqualTo: tel)
        .getDocuments()
        .then((QuerySnapshot docs) {
      if (docs.documents.isNotEmpty) {
        data = docs.documents[0].data;
        if (data["mdp"] == mdp) {
          print(data);
          user.id = docs.documents[0].documentID;
          user.nom = data["nom"];
          user.prenom = data["prenom"];
          Persist p = new Persist();
          p.setId(user.id);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => pp.MyApp(
                        userid: user.id,
                      )),
              (Route<dynamic> route) => false);
        } else
          _showDialog("Probléme d'identifiant.",
              "Le mot de passe que vous avez entré est incorrect.\nVeuillez vérifier vos informations de connexion!");
      } else {
        data = null;
        print("There is nothing");
        _showDialog("Utilisateur introuvable.",
            "Veuillez vérifier vos informations de connexion!");
      }
    });
  }

  _checkInternetConnectivity() async {
    var result = await Connectivity().checkConnectivity();
    setState(() {
      connect = (result == ConnectivityResult.none) ? false : true;
    });
  }

  _showDialog(title, content) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = Screen(MediaQuery.of(context).size).wp;
    final Function hp = Screen(MediaQuery.of(context).size).hp;

    ResponsiveWidgets.init(
      context,
      height: 1920, // Optional
      width: 1080, // Optional
      allowFontScaling: true, // Optional
    );

    return ResponsiveWidgets.builder(
      height: 1920, // Optional
      width: 1080, // Optional
      allowFontScaling: true, // Optional

      child: Scaffold(
        appBar: AppBar(
          title: Text('Connexion'),
          elevation: 10,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(15),
          color: Color(0xff37474f),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image.asset(
                'assets/images/logo.png',
                height: hp(15),
              ),
              SizedBox(
                height: hp(2),
              ),
              TextField(
                style: TextStyle(fontSize: 18, color: Colors.black54),
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Téléphone',
                  contentPadding: const EdgeInsets.all(15),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onChanged: (input) {
                  setState(() {
                    _message = input.length != 9
                        ? "Entrer un numéro de Téléphone valide."
                        : "";
                    _tel = input;
                  });
                },
              ),
              SizedBox(
                height: hp(3),
              ),
              TextField(
                obscureText: true,
                style: TextStyle(fontSize: 18, color: Colors.black54),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Mot de passe',
                  contentPadding: const EdgeInsets.all(15),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onChanged: (input) {
                  setState(() {
                    _mdp = input;
                  });
                },
              ),
              SizedBox(
                height: hp(1),
              ),
              Text(
                _message,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: hp(2),
              ),
              Bounce(
                duration: Duration(milliseconds: 200),
                child: NiceButton(
                  background: secondColor,
                  radius: 40,
                  padding: const EdgeInsets.all(15),
                  text: "Se connecter",
                  gradientColors: [secondColor, firstColor],
                ),
                onPressed: () {
                  _checkInternetConnectivity();
                  if (connect && _tel.length > 0 && _mdp.length > 0) {
                    user = new User(null, null, _tel, _mdp);
                    signIn(user.tel, user.mdp);
                  } else {
                    _showDialog("Probléme de connexion.",
                        "Verifier votre connexion internet ou que les informations entrées sont correctes!!");
                  }
                },
              ),
              FlatButton(
                child: Text(
                  'Mot de passe oublié?',
                  //style: TextStyle(fontSize: 20),
                  style: TextStyle(
                    color: Color(0xffff4757).withOpacity(0.6),
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.underline,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.upToDown,
                          duration: Duration(seconds: 1),
                          child: ForgetPasswordPage()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
