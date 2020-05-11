import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_maps/screens/getting_started_screen.dart';
import 'package:nice_button/NiceButton.dart';
import 'package:flutter_maps/mapper.dart' as mp;


class NumberScreen extends StatefulWidget{
  static const routeName = '/number';
  @override
  _NumberScreenState createState() => _NumberScreenState();
}

class _NumberScreenState extends State<NumberScreen>{
  String  _tel; 
  String sms_code, verifId;

  Future<void> verifyPhone() async {

    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verifId){
      this.verifId = verifId;
    };
    final PhoneCodeSent smsCodeSent = (String verifId, [int forceCodeResent]){
      this.verifId = verifId;
    };
    final PhoneVerificationCompleted verified = (AuthCredential authResult){
      print("Ca marrrrrche *****************!!!!!!!!!");
      AuthService().signIn(authResult);
      
    };
    final PhoneVerificationFailed unverified = (AuthException authException){
        print("Ca NE marrrrrche PAAAAAASS *****************");
        print(authException.message);
        
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: _tel, 
      timeout: const Duration(seconds: 5), 
      verificationCompleted: verified, 
      verificationFailed: unverified, 
      codeSent: smsCodeSent, 
      codeAutoRetrievalTimeout: autoRetrieve);
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
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    NiceButton(
                      background:secondColor ,
                      radius: 40,
                      padding: const EdgeInsets.all(15),
                      text: "S'inscrire",
                      gradientColors: [secondColor, firstColor],
                      onPressed: ()=> verifyPhone(),
                    )
                  ]
                )
              )
            )
          );
        }
      )
    );
  }
}

class AuthService{
  handleAuth(){
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot){
        if(snapshot.hasData){
          return mp.MyHomePage(title: "Mapper",);
        }
        else{
          return NumberScreen();
        }
      },
    );
  }
  signOut(){
    FirebaseAuth.instance.signOut();
  }
  signIn(AuthCredential authCredential){
    print("******************************SIGNING IN");

    FirebaseAuth.instance.signInWithCredential(authCredential);
  }
}