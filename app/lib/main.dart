import 'package:flutter/material.dart';
import 'myhomepage.dart';
import 'config.dart';
import 'newspage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Config.title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: /*NewsPage()*/MyHomePage(),
    );
  }
}

