import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_maps/persist.dart';
import 'user.dart';
import 'package:flutter/material.dart';
import 'package:nice_button/nice_button.dart';
import 'package:flutter_maps/page_principale.dart' as pp;



var firstColor = Color(0xff5b86e5), secondColor = Color(0xff36d1dc);

class SignupScreen extends StatefulWidget{
  static const routeName = '/signup';
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  User user;
  
  String _nom, _prenom, _mdp, _message="", _tel;
  bool _confirm = true, connect;

  _setMessage(){
    setState(() {
      _message = (_confirm) ?"" :"Les deux mots de passe ne correspondent pas.";
    });
    
  }

  _checkInternetConnectivity() async{
    var result = await Connectivity().checkConnectivity();
    setState(() {
      connect = (result == ConnectivityResult.none) ? false: true;
    });
  }
  _showDialog(title, content){
    showDialog(
      context:context,
      builder: (context){
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
      }
    );
  } 
  
  signIn(tel, mdp) async{
    var data;
    await Firestore.instance.collection("User")
    .where("tel", isEqualTo:tel)
    .where("mdp", isEqualTo:mdp)
    .getDocuments().then((QuerySnapshot docs){
      if(docs.documents.isNotEmpty){
        data = docs.documents[0].data;
        print(data);
        user.id = docs.documents[0].documentID;
        user.nom = data["nom"];
        user.prenom = data["prenom"];
        Persist p = new Persist();
        p.setId(user.id);
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          pp.MyApp(userid: user.id,)), (Route<dynamic> route) => false);
      }
      else {
        print("There is nothing");
        _showDialog("Connexion au serveur impossible", "Veuillez attendre un instant...");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inscription'),
        elevation: 10,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
            ),
            color: Color(0xff37474f),
            width: double.infinity,
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/logo.png',
                      height: 130,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      style: TextStyle(fontSize: 18, color: Colors.black54),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Prénom',
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
                      onChanged: (input){
                        setState(() {
                          _prenom = input;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    
                    TextField(
                      style: TextStyle(fontSize: 18, color: Colors.black54),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Nom',
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
                      onChanged: (input){
                        setState(() {
                          _nom = input;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      keyboardType: TextInputType.phone,
                      style: TextStyle(fontSize: 18, color: Colors.black54),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Téléphone',
                        contentPadding: const EdgeInsets.all(15),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onChanged: (input){
                        setState(() {
                          _tel = input;
                          _message = input.length != 9? "Entrer un numéro de Téléphone valide.": "";
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
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
                      onChanged: (input){
                        setState(() {
                          _mdp = input;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      obscureText: true,
                      style: TextStyle(fontSize: 18, color: Colors.black54),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Confirmer le mot de passe',
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
                          (_mdp == input)? _confirm=true : _confirm=false;
                        });
                        _setMessage();
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      _message,
                      style: TextStyle(
                        color:Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    NiceButton(
                      background:secondColor ,
                      radius: 40,
                      padding: const EdgeInsets.all(15),
                      text: "S'inscrire",
                      gradientColors: [secondColor, firstColor],
                      onPressed: (){
                        try{
                          _checkInternetConnectivity();
                          if(connect){
                            if(_tel.length==9){
                              user = new User(_prenom, _nom, _tel, _mdp);
                              user.addNewUser();
                              signIn(user.tel, user.mdp);
                              
                            }
                            else _showDialog("Numéro de téléphone", "Vérifier votre numéro de téléphone");
                          }
                          else _showDialog("Probléme de connection.", "Verifier votre connection internet!");
                        }catch(e){
                          print(e.message);
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class TestScreen extends StatelessWidget{
  static final routeName = "/route";
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: Text("TESTE"),),
      body: Center(
        child: Text("Hello World")
      ),
    );
  }
}