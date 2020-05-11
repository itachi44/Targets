import 'dart:async';
import 'package:flutter_responsive_screen/flutter_responsive_screen.dart';
import 'package:responsive_widgets/responsive_widgets.dart';
import 'package:flutter/material.dart';
import 'package:nice_button/nice_button.dart';
import '../widgets/slide_item.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:page_transition/page_transition.dart';
import '../model/slide.dart';
import '../widgets/slide_dots.dart';
import '../screens/login_screen.dart';
import '../screens/signup_screen.dart';

var firstColor = Color(0xff5b86e5), secondColor = Color(0xff36d1dc);

class GettingStartedScreen extends StatefulWidget {
  @override
  _GettingStartedScreenState createState() => _GettingStartedScreenState();
}

class _GettingStartedScreenState extends State<GettingStartedScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    final Function wp = Screen(MediaQuery.of(context).size).wp;
    final Function hp = Screen(MediaQuery.of(context).size).hp;

    ResponsiveWidgets.init(context,
		    height: 1920, // Optional
		    width: 1080, // Optional
			allowFontScaling: true, // Optional
	    );

  return  ResponsiveWidgets.builder(
			height: 1920, // Optional
		    width: 1080, // Optional
			allowFontScaling: true, // Optional

 child :Scaffold(
      body: ContainerResponsive(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsetsResponsive.all(20),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: <Widget>[
                    PageView.builder(
                      scrollDirection: Axis.horizontal,
                      controller: _pageController,
                      onPageChanged: _onPageChanged,
                      itemCount: slideList.length,
                      itemBuilder: (ctx, i) => SlideItem(i),
                    ),
                    Stack(
                      alignment: AlignmentDirectional.topStart,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsetsResponsive.only(bottom: 35),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              for(int i = 0; i<slideList.length; i++)
                                if( i == _currentPage )
                                  SlideDots(true)
                                else
                                  SlideDots(false)
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBoxResponsive(
                height: hp(20),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[

                    Bounce(

                    duration: Duration(milliseconds: 100),
                    child: NiceButton(
                    background: firstColor,
                    radius: 40,
                     text: "Commencer",
                     fontSize: ScreenUtil()
                            .setSp(50, allowFontScalingSelf: true),
                    icon: Icons.account_box,
                    gradientColors: [secondColor, firstColor],
                    
                    padding: EdgeInsetsResponsive.all(35),
                    textColor: Colors.white,
                    
                    
                  ),
                    onPressed: () {
                      Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, duration: Duration(seconds: 1),child: SignupScreen()));
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Vous avez déja un compte?',
                        style: TextStyle(
                          fontSize: ScreenUtil()
                            .setSp(30, allowFontScalingSelf: true),
                        ),
                      ),
                      FlatButton(
                        child: Text(
                          'Se Connecter',
                          style: TextStyle(fontSize: ScreenUtil()
                            .setSp(30, allowFontScalingSelf: true)),
                        ),
                        onPressed: () {
                          Navigator.push(context, PageTransition(type: PageTransitionType.upToDown, duration: Duration(seconds:1),child: LoginScreen()));
                        },
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
 ),
    );
  
  }
}
