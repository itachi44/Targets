import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_maps/getData.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart' as mainer;

class Settings extends StatefulWidget {
  Settings({Key key, this.userId}) : super(key: key);

  final String userId;
  static const routeName = '/settings';
  @override
  _Settings createState() {
    return new _Settings();
  }
}

class _Settings extends State<Settings> {
  _Settings({this.userId});

  String prenom;
  String nom;
  String numero;
  final String userId;
  bool autoriser = true;
  bool _connect=false;
  Map<String,String> values;
  @override
  void initState() {
    super.initState();
    Data data = Data();
    // values = data.getData(userId);
    // if(values!=null){
    //   print(values);
    //   prenom = values["prenom"];
    //   nom = values["nom"];
    //   numero = values["tel"];
    // }
    // else
    //   print("Values est videeeeeeeeee!!!!");

    _checkInternetConnectivity();
  }

  _checkInternetConnectivity() async {
    var result = await Connectivity().checkConnectivity();
    _connect = (result == ConnectivityResult.none) ? false : true;
  }

  void _saveData() async {
    await Firestore.instance.collection("User").document(userId).updateData({
      "nom": nom,
      "prenom": prenom,
      "tel": numero,
      //"mdp":
    }).then((_) {
      print("successfully Saved!!!!!!!!!!!! No Problemo!");
      _showDialog("Sauvegarde compléte!", "Vos données ont été mises à jour!\nNouvelles données : \nPrénom : $prenom\nNom : $nom\nNuméro : $numero");
    });
  }

  _logOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userId');
    prefs.clear();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => mainer.MyApp()),
        (Route<dynamic> route) => false);
  }


  _logOutDialog(title, content) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              FlatButton(
                child: Text("NON"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text("OUI"),
                onPressed: () {
                  _logOut();
                },
              )
            ],
          );
        });
  }

  _showDialog(title, content) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(
            'Settings',
          ),
          centerTitle: true,
          elevation: 5.0,
        ),
        body: new Center(
            child: Container(
          padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
          child: Column(
            children: <Widget>[
              new Card(
                child: new Row(
                  children: <Widget>[
                    Text("Autoriser l'accès aux données"),
                    Switch(
                        value: autoriser,
                        onChanged: (value) {
                          autoriser = !autoriser;
                          setState(() {
                            value = autoriser;
                          });
                        })
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
              ),
              new Card(
                child: Row(
                  children: <Widget>[
                    Flexible(
                        child: TextFormField(
                      decoration:
                          InputDecoration(hintText: "Modifier votre prenom"),
                      onChanged: (String string) {
                        setState(() {
                          prenom = string;
                        });
                      },
                      initialValue: prenom,
                    )),
                    IconButton(icon: Icon(Icons.create), onPressed: () {})
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
              ),
              new Card(
                child: Row(
                  children: <Widget>[
                    Flexible(
                        child: TextFormField(
                      decoration:
                          InputDecoration(hintText: "Modifier votre nom"),
                      onChanged: (String string) {
                        setState(() {
                          nom = string;
                        });
                      },
                      initialValue: nom,
                    )),
                    IconButton(icon: Icon(Icons.create), onPressed: () {})
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
              ),
              new Card(
                child: Row(
                  children: <Widget>[
                    Flexible(
                        child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration:
                          InputDecoration(hintText: "Modifier votre numéro"),
                      onChanged: (String string) {
                        setState(() {
                          numero = string;
                        });
                      },
                      initialValue: numero,
                    )),
                    IconButton(icon: Icon(Icons.create), onPressed: () {})
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
              ),
              RaisedButton(
                elevation: 5.0,
                padding: EdgeInsets.all(10.0),
                child: new Text("Enregistrer"),
                textColor: Colors.white,
                color: Colors.blue,
                onPressed: () {
                  _checkInternetConnectivity();
                  _connect
                      ? _saveData()
                      : _showDialog("Accès Internet",
                          "Nous ne pouvons pas accéder au serveur. Veuillez vérifier votre connection internet");
                },
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                elevation: 5.0,
                padding: EdgeInsets.all(10.0),
                onPressed: () {
                  _logOutDialog("Confirmation",
                      "Voulez vous vraiment vous déconnecter ?");
                },
                child: new Text("Se Déconnecter."),
                textColor: Colors.white,
                color: Colors.red,
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
        )));
  }
}
