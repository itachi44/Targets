import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  static const routeName = '/settings';
  @override
  _Settings createState() {
    return new _Settings();
  }
}

class _Settings extends State<Settings> {
  String prenom;
  String nom;
  String numero;
  bool autoriser = true;

  @override
  void initState() {
    super.initState();
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
                        child: TextField(
                      decoration:
                          InputDecoration(hintText: "Modifier votre prenom"),
                      onChanged: (String string) {
                        setState(() {
                          prenom = string;
                        });
                      },
                      onSubmitted: (String string) {
                        prenom = string;
                      },
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
                        child: TextField(
                      decoration:
                          InputDecoration(hintText: "Modifier votre nom"),
                      onChanged: (String string) {
                        setState(() {
                          nom = string;
                        });
                      },
                      onSubmitted: (String string) {
                        nom = string;
                      },
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
                        child: TextField(
                      keyboardType: TextInputType.number,
                      decoration:
                          InputDecoration(hintText: "Modifier votre numéro"),
                      onChanged: (String string) {
                        setState(() {
                          numero = string;
                        });
                      },
                      onSubmitted: (String string) {
                        numero = string;
                      },
                    )),
                    IconButton(icon: Icon(Icons.create), onPressed: () {})
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
              ),
              RaisedButton(
                elevation: 5.0,
                padding: EdgeInsets.all(10.0),
                onPressed: () {},
                child: new Text("Enregistrer"),
                textColor: Colors.white,
                color: Colors.blue,
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
        )));
  }
}
