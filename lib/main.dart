import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tunaiku/pages/register.dart';

void main() {
  runApp(MaterialApp(
    localizationsDelegates: [GlobalMaterialLocalizations.delegate],
    supportedLocales: [const Locale('en'), const Locale('id')],
    builder: (context, child) {
      return MediaQuery(
        child: child,
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      );
    },
    home: SplashScreen(),
    routes: <String, WidgetBuilder>{
      RegisterPage.routeName: (ctx) => new RegisterPage(),
    },
  ));
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 4);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() async {
    Navigator.of(context).pushReplacementNamed(RegisterPage.routeName);
  }

  @override
  void initState() {
    super.initState();

    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(body: mainUI());
  }
}

Widget mainUI() {
  return new Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Center(
          child: new Text("Tunaiku"),
        ),
      ],
    ),
  );
}
