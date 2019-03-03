import 'package:flutter/material.dart';
import 'config.dart';
import 'newspage.dart';
import 'news.dart';
import 'dart:async' show Future, Stream, StreamSubscription;
import 'dart:convert';
import 'settings.dart';
import 'package:http/http.dart' as http;
import 'loader.dart';
import 'myhomepage.dart';

class Home extends StatefulWidget {
  static String tag="Home";
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home>
    with SingleTickerProviderStateMixin {
  
  
  int _index=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Colors.grey[200],
      
      body: (_index==0)?MyHomePage():SettingsPage(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (i) => setState(() {
              _index = i;
            }),
        currentIndex: _index,
        fixedColor: Colors.grey,
        type: BottomNavigationBarType.shifting,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: (_index == 0) ? Colors.blue : Colors.grey[600],
              ),
              title: Text("Home", style: TextStyle(color: Colors.grey[600]))),
          /*    BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: (_index == 1) ? Colors.blue : Colors.grey[600],
              ),
              title: Text("Search", style: TextStyle(color: Colors.grey[600]))),
       */
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: (_index == 1) ? Colors.blue : Colors.grey[600],
              ),
              title:
                  Text("Settings", style: TextStyle(color: Colors.grey[600]))),
        ],
      ),
    );
  }
}
