import 'package:flutter/material.dart';
import 'myhomepage.dart';
import 'config.dart';
import 'newspage.dart';
import 'settings.dart';
import 'home.dart';
import 'SplashScreen.dart';

void main() => runApp(MyApp());

final routes = <String, WidgetBuilder>{
    Home.tag: (context) => Home(),
    SplashScreen.tag: (context) => SplashScreen(),
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Config.title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: routes,
      home: SplashScreen(),
    );
  }
}

