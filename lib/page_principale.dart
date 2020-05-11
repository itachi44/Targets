import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter_maps/persist.dart';
import 'package:image_auto_slider/image_auto_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'settings.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'mapper.dart' as map;


class MyApp extends StatelessWidget {
  static const routeName = '/homePage';
  final String userid;

  MyApp({Key key, @required this.userid}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Target',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Target'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


Widget _buildTile(Widget child, {Function() onTap}) {
    return Material(
      elevation: 14.0,
      borderRadius: BorderRadius.circular(12.0),
      shadowColor: Color(0x802196F3),
      child: InkWell
      (
        // Do onTap() if it isn't null, otherwise do something
        onTap: onTap != null ? () => onTap() : () { },
        child: child
      )
    );
  }


class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final bodies = [
    Center(
      child: new Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            ImageAutoSlider(
              assetImages: [
                AssetImage('img/img11.png'),
                AssetImage('img/img2.png'),
                AssetImage('img/img3.png'),
                AssetImage('img/img4.png'),
                AssetImage('img/img5.png'),
                AssetImage('img/img6.png'),
              ],
              slideMilliseconds: 700,
              durationSecond: 5,
              boxFit: BoxFit.scaleDown,
            ),

        

        Column(
                 
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
            // bodies[_currentIndex],


             SizedBox(
                      height: 40,
                    ),



        Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: 
       <Widget>[
         
         _buildTile(
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column
              (
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>
                [
                  Material
                  (
                    color: Colors.teal,
                    shape: CircleBorder(),
                    child: Padding
                    (
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(Icons.healing, color: Colors.white, size: 30.0),
                    )
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 16.0)),
                  Text('Auto-Diagnostique', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 24.0)),
                  Text('Faites des tests vous même', style: TextStyle(color: Colors.black45)),
                ]
              ),
            ),
          ),
          _buildTile(
            Padding
            (
              padding: const EdgeInsets.all(24.0),
              child: Column
              (
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>
                [
                  Material
                  (
                    color: Colors.amber,
                    shape: CircleBorder(),
                    child: Padding
                    (
                      padding: EdgeInsets.all(16.0),
                      child: Icon(Icons.notifications, color: Colors.white, size: 30.0),
                    )
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 16.0)),
                  Text('Alerts', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 24.0)),
                  Text('Nous prévenir ', style: TextStyle(color: Colors.black45)),
                ]
              ),
            ),
          ),
         
        ],
                  
),

    ],
    ),


          ],
        ),
      ),
    ),
    Center(
      child: Text("Stats"),
    ),
    Center(),
    Center(
      child: Text("Share"),
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
          elevation: 8.0,
          primary: true,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (BuildContext context) {
                    return new Settings();
                  }));
                })
          ],
        ),
       



         floatingActionButton:
         Container(
        height: 70.0,
        width: 70.0,
        child: FittedBox(
          child: 
          FloatingActionButton(
          child: Icon(
            Icons.location_on,
            color: Colors.red,
            size: 60.0,
          ),
          backgroundColor: Colors.white,
          onPressed: () {
            Navigator.push(context,
                new MaterialPageRoute(builder: (BuildContext context) {
              return new map.MyHomePage(title: "Carte");
            }));
          },
          ),
        ),
         ),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: _currentIndex,
          showElevation: true,
          onItemSelected: (index) => setState(() {
            _currentIndex = index;
          }),
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(title: Text('Accueil'), icon: Icon(Icons.home,size: 30,)),
            BottomNavyBarItem(
                title: Text('stats'), icon: Icon(Icons.assessment,size: 30,),),
            BottomNavyBarItem(
                title: Text('profil'), icon: Icon(Icons.account_circle,size:30)),
            BottomNavyBarItem(
                title: Text('inviter'), icon: Icon(Icons.group_add, size:30,)),
          ],
        ));
  }
 
}
