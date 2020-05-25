import 'package:flutter/material.dart';
//
import 'dart:async';
import 'package:flutter/services.dart';
//
import 'package:Eventory/screens/join.dart'; //destination


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTimeout() {
    return Timer(Duration(seconds: 3), changeScreen);
  }

  changeScreen() async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return JoinApp();
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    startTimeout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        margin: EdgeInsets.only(left: 40.0, right: 40.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image.asset('assets/eventory.png'),
            ],
          ),
        ),
      ),
    );
  }
}
