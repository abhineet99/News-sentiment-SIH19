import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';
//import 'package:after_layout/after_layout.dart';
import 'config.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Modals.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class SignIn{
  static final GoogleSignIn _googleSignIn = GoogleSignIn();
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  
  static Future<User> handleSignIn() async {
    try{
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    FirebaseUser user = await _auth.signInWithGoogle(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    
    String id=await user.getIdToken();
    String mobileNo=await user.phoneNumber;
    String name =await user.displayName;
    String emailId=await user.email;
    String photoUrl=user.photoUrl;
    User _user=new User(id:id,name: name,mobileNo: mobileNo,emailId: emailId,photoUrl: photoUrl );

    

    return _user;
    }catch(e){
    print("\n exception\n");
      throw (e);
    }
  }

  static saveUser(User _user) async{
    try{
      SharedPreferences prefs=await SharedPreferences.getInstance();
      await prefs.setString('idToken', _user.id);
      await prefs.setString('mobileNo', _user.mobileNo);
      await prefs.setString('name', _user.name);
      await prefs.setString("emailId", _user.emailId);
      await prefs.setString("photoUrl", _user.photoUrl);
    
    }catch(e){
      print("\n exception\n");
            print(e);
      //throw(e);
    }
    
  }
  static Future<User> getUser() async{
    try{
      SharedPreferences prefs=await SharedPreferences.getInstance();
      String idToken=await prefs.getString('idToken');
      String name= await prefs.getString('name');
      String mobileNo=await prefs.getString('mobileNo');
      String emailId=await prefs.getString('emailId');
      String photoUrl=await prefs.getString('photoUrl');
      return User(id: idToken,name: name,mobileNo: mobileNo,emailId:emailId,photoUrl: photoUrl );
    }catch(e){
      print(e);
      //throw(e);
    }
    
  }
  static Future<void> logout() async{
    FirebaseAuth.instance.signOut();
    SharedPreferences prefs=await SharedPreferences.getInstance();
     await prefs.setString('idToken', null);
      await prefs.setString('mobileNo', null);
      await prefs.setString('name', null);
      await prefs.setString("emailId", null);
      await prefs.setString("emailId", null);

  }

  
  
}
