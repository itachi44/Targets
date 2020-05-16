import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:image_auto_slider/image_auto_slider.dart';
import 'settings.dart';
import 'mapper.dart' as map;
import 'package:url_launcher/url_launcher.dart';
import './AutoDiag/intro.dart';

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
      home: MyHomePage(title: 'Target', userId: userid),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.userId}) : super(key: key);

  final String title;
  final String userId;

  @override
  _MyHomePageState createState() => _MyHomePageState(userId: userId);
}
Widget _buildTile(Widget child, {Function() onTap}) {
  return Material(
      elevation: 14.0,
      borderRadius: BorderRadius.circular(12.0),
      shadowColor: Color(0x802196F3),
      child: InkWell(
          // Do onTap() if it isn't null, otherwise do something
          onTap: onTap != null ? () => onTap() : () {},
          child: child));
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState({this.userId});
  String userId;
  int _currentIndex = 0;

  
  @override
  Widget build(BuildContext context) {
    final bodies = [
    Center(
      child: new Container(
        margin: EdgeInsets.all(10.0),
        child: 
        Column(
          children: <Widget>[
            ImageAutoSlider(
              assetImages: [
                AssetImage('img/img11.jpg'),
                AssetImage('img/img2.png'),
                AssetImage('img/img3.png'),
                AssetImage('img/img4.jpg'),
                AssetImage('img/img5.jpg'),
                AssetImage('img/img6.jpg'),
              ],
              slideMilliseconds: 700,
              durationSecond: 5,
              boxFit: BoxFit.scaleDown,
            ),
            
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                //

                SizedBox(
                  height: 15,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildTile(
                      Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Material(
                                  color: Colors.teal,
                                  shape: CircleBorder(),
                                  child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Icon(Icons.healing,
                                        color: Colors.white, size: 30.0),
                                  )),
                              Padding(padding: EdgeInsets.only(bottom: 16.0)),
                              Text('Auto-Diagnostique',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 24.0)),
                              Text('Faites des tests vous même',
                                  style: TextStyle(color: Colors.black45)),
                            ]),
                      ),
                      onTap: () =>Navigator.of(context).push(MaterialPageRoute(builder: (_) => DiagnosticIntro())),

                    ),
                    _buildTile(
                        Padding(
                          padding: EdgeInsets.all(24.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Material(
                                    color: Colors.amber,
                                    shape: CircleBorder(),
                                    child: Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Icon(Icons.notifications,
                                          color: Colors.white, size: 30.0),
                                    )),
                                Padding(padding: EdgeInsets.only(bottom: 16.0)),
                                Text('Alerts',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 24.0)),
                                Text('Nous prévenir ',
                                    style: TextStyle(color: Colors.black45)),
                              ]),
                        ),
                        onTap: () => launch("tel://800005050")),
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
        body: bodies[_currentIndex],
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.location_on,
            color: Colors.red,
            size: 40.0,
          ),
          backgroundColor: Colors.white,
          onPressed: () {
            Navigator.push(context,
                new MaterialPageRoute(builder: (BuildContext context) {
              return new map.MyHomePage(title: "Carte", userId: userId);
            }));
          },
        ),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: _currentIndex,
          showElevation: true,
          onItemSelected: (index) => setState(() {
            _currentIndex = index;
          }),
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
                title: Text('Accueil'),
                icon: Icon(
                  Icons.home,
                  size: 27,
                )),
            BottomNavyBarItem(
              title: Text('stats'),
              icon: Icon(
                Icons.assessment,
                size: 27,
              ),
            ),
            BottomNavyBarItem(
                title: Text('profil'),
                icon: Icon(Icons.account_circle, size: 27)),
            BottomNavyBarItem(
                title: Text('inviter'),
                icon: Icon(
                  Icons.group_add,
                  size: 27,
                )),
          ],
        ));
  }
}
