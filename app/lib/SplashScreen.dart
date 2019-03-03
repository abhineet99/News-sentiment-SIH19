import 'package:flutter/material.dart';
import 'config.dart';
import 'dart:async';
import 'home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'Modals.dart';

class SplashScreen extends StatelessWidget {
  home(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(Home.tag);
  }

  handleAuth(BuildContext context) async {
    User user;
    try {
      user = await SignIn.getUser();
    } catch (e) {
      print(e);
      user.id = null;
    }
    if (user.id != null) {
      home(context);
    } else {
      try {
        User user = await SignIn.handleSignIn();
        SignIn.saveUser(user);
        home(context);
      } catch (e) {
        print(e);
        //TODO call ShowToast to show a toast
      }
    }
  }

  static String tag = 'SplashScreen';
  @override
  Widget build(BuildContext context) {
    //home(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Expanded(
            flex: 1,
            child: new Container(),
          ),
          new Expanded(
            flex: 1,
            child: new Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage("assets/app_icon.png")
                )
              ),
              //child: Center(child: Text("Logo here")),
            ),
          ),
          new Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  Config.title.toUpperCase(),
                  style: TextStyle(color: Colors.green[400], fontSize: 40),
                ),
              )),
          new Expanded(
            flex: 1,
            child: new Container(
              child: FlatButton(
                onPressed: () => handleAuth(context), //home(context),
                child: Text("ENTER",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    )),
              ),
              decoration: BoxDecoration(
                  // color: Colors.green[700],
                  ),
            ),
          ),
          new Expanded(
            flex: 1,
            child: new Container(),
          ),
        ],
      )),
    );
  }
}
