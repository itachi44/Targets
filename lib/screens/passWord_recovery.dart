import 'package:flutter/material.dart';


class ForgetPasswordPage extends StatefulWidget{
  static const routeName = '/recover';

  @override
  State<StatefulWidget> createState() => _ForgetPasswordPageState();

}

class _ForgetPasswordPageState extends State<ForgetPasswordPage>{
  FocusNode _focusNode;
  TextEditingController _numController;
 final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Widget _body(BuildContext context){
  return Container(
    //height: fullHeight(context),
    padding: EdgeInsets.symmetric(horizontal: 30),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _label(),
          SizedBox(height: 50,),
          _entryFeild('Entrer votre numéro',controller: _numController),
          // SizedBox(height: 10,),
          _submitButton(context),
      ],)
  );
}
  Widget _entryFeild(String hint,{TextEditingController controller,bool isPassword = false}){
  return Container(
    margin: EdgeInsets.symmetric(vertical: 15),
    decoration: BoxDecoration(
      color: Colors.grey.shade200,
      borderRadius: BorderRadius.circular(30)
    ),
    child: TextField(
      focusNode: _focusNode,
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(fontStyle: FontStyle.normal,fontWeight: FontWeight.normal),
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hint,

        border: InputBorder.none,
        focusedBorder: OutlineInputBorder(
           borderRadius: BorderRadius.all(Radius.circular(30.0)),
              borderSide: BorderSide(color: Colors.blue)),
        contentPadding:EdgeInsets.symmetric(vertical: 15,horizontal: 10)
      ),
    ),
  );
}
  Widget _submitButton(BuildContext context){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      width: MediaQuery.of(context).size.width,
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        color: Color(0xff2196F3),
        onPressed: () {},
        padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
        child: Text('Envoyer',style:TextStyle(color: Colors.white,fontSize: 20)),
      )
    );
  }
  Widget _label(){
    return Container(
      child:Column(
        children: <Widget>[
          Text('Mot de passe oublié',style:TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Color(0xffffffff))),
          SizedBox(height: 15),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text('Entrer votre numéro de téléphone pour réinitialiser votre mot de passe.',
          style:TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Color(0xffffffff)),textAlign: TextAlign.center),

          )
        ],
      )
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Forget Password',style: TextStyle(fontSize: 20)),
        centerTitle: true,
      ),
      body: _body(context),
      backgroundColor: Color(0xff37474f),
    );
  }
  
}