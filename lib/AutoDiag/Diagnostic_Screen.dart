import 'package:flutter/material.dart';
import './auto_diag.dart';


AutoDiag quizBrain = AutoDiag();

class Diagnostic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xff455A64),
        appBar: AppBar(
          title: Text('diagnostic test'),
          elevation: 10,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: TestPage(),
          ),
        ),
      ),
    );
  }
}

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  List<Widget> scoreKeeper = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child:  MaterialButton(
               onPressed: () {
                bool result = quizBrain.getCorrectAnswer();

                setState(() {
//                  scoreKeeper.add(
//                    Icon(
//                      Icons.close,
//                      color: Colors.red,
//                    ),
//                  );
                  quizBrain.nextQuestion();
                });
                print(result == false);
              },
        child: Text(
          'Oui',
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Alike",
            fontSize: 22.0,
          ),
          maxLines: 1,
        ),
        color: Color(0xff1976D2),
        splashColor: Colors.indigo[700],
        highlightColor: Colors.indigo[700],
        minWidth: 200.0,
        height: 45.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: 
            
            MaterialButton(
               onPressed: () {
                bool result = quizBrain.getCorrectAnswer();

                setState(() {
//                  scoreKeeper.add(
//                    Icon(
//                      Icons.close,
//                      color: Colors.red,
//                    ),
//                  );
                  quizBrain.nextQuestion();
                });
                print(result == false);
              },
        child: Text(
          'Non',
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Alike",
            fontSize: 22.0,
          ),
          maxLines: 1,
        ),
        color: Color(0xff1976D2),
        splashColor: Colors.indigo[700],
        highlightColor: Colors.indigo[700],
        minWidth: 200.0,
        height: 45.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
            
          ),
        ),
        Expanded(
          child: Row(
            children: scoreKeeper,
          ),
        ),
      ],
    );
  }
}
