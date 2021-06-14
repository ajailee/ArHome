import 'dart:async';

import 'package:aj_ar/Screen/CategoryScreen.dart';
import 'package:aj_ar/Screen/HomeScreen.dart';
import 'package:aj_ar/Screen/BuilderScreen.dart';
import 'package:aj_ar/Screen/Settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

class MyPageView extends StatefulWidget {
  static String routeName = '/';

  @override
  _MyPageViewState createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeScrenn(),
    CategoryScreen(),
    BuilderScreen(),
    MySettings(),
  ];
  // bottom Nav bar settings
  var snakeBarStyle = SnakeBarBehaviour.floating;
  var snakeShape = SnakeShape.circle;

  var bottomBarShape =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(20));
  //Animation
  AnimationController animationController;
  Animation degOneTranslationAnimation,
      degTwoTranslationAnimation,
      degThreeTranslationAnimation;
  Animation rotationAnimation;
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  Future<void> initConnectivity() async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  @override
  void initState() {
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
    degOneTranslationAnimation = TweenSequence(<TweenSequenceItem>[
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.2), weight: 75.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.2, end: 1.0), weight: 25.0),
    ]).animate(animationController);
    degTwoTranslationAnimation = TweenSequence(<TweenSequenceItem>[
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.4), weight: 55.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.4, end: 1.0), weight: 45.0)
    ]).animate(animationController);
    degThreeTranslationAnimation = TweenSequence(<TweenSequenceItem>[
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.75), weight: 35.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.75, end: 1.0), weight: 65.0)
    ]).animate(animationController);
    rotationAnimation = Tween<double>(begin: 180.0, end: 0.0).animate(
        CurvedAnimation(
            parent: animationController, curve: Curves.easeOutCirc));
    super.initState();
    degOneTranslationAnimation.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    _connectivitySubscription.cancel();
    super.dispose();
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: _connectionStatus == ConnectivityResult.none
          ? Center(
              child: Image.asset('assets/nonet.gif'),
            )
          : Scaffold(
              body: _children[_currentIndex], // new
              bottomNavigationBar: SnakeNavigationBar.color(
                snakeViewColor: Colors.white,
                onTap: onTabTapped,
                elevation: 0.0,
                selectedItemColor: Colors.black,
                unselectedItemColor: Colors.white,
                currentIndex: _currentIndex,
                padding: EdgeInsets.all(10),
                behaviour: snakeBarStyle,
                snakeShape: snakeShape,
                shape: bottomBarShape,
                showSelectedLabels: true,
                items: [
                  const BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.home), label: 'Home'),
                  const BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.search), label: 'Category'),
                  const BottomNavigationBarItem(
                      icon: Icon(Icons.construction), label: 'Search'),
                  const BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.settings), label: 'Settings'),
                ],
                selectedLabelStyle: const TextStyle(fontSize: 14),
                unselectedLabelStyle: const TextStyle(fontSize: 10),
              )),
    );
  }
}
