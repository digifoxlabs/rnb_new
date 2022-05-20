// @dart=2.9
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rnb/home_screen_admin.dart';
import 'package:rnb/home_screen_category.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen_security.dart';
import 'login_screen.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Splash());
}

class Splash extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Splash_page(),
    );
  }
}

class Splash_page extends StatefulWidget {

  @override
  _Splash_pageState createState() => _Splash_pageState();
}

class _Splash_pageState extends State<Splash_page> {


  checkLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("id") != null) {
      Timer(Duration(seconds: 3),
              () async {SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          String role = sharedPreferences.getString("role");
          switch(role){
            case "admin":
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                  builder: (BuildContext context) => HomeScreenAdmin()), (
                  Route<dynamic> route) => false);
              break;
            case "subadmin":
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                  builder: (BuildContext context) => HomeScreenCategory()), (
                  Route<dynamic> route) => false);
              break;
            case "security":
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                  builder: (BuildContext context) => HomeScreenSecurity()), (
                  Route<dynamic> route) => false);
              break;
          }

          });
    }
    else{
      Timer(Duration(seconds: 3),
              ()=>Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => loginScreen()), (Route<dynamic> route) => false));
    }
  }
  @override
  void initState() {
    super.initState();
      // Todo: Uncomment while release
   checkLogin();

  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient : LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xffECE9E6),Color(0xffFFFFFF)]
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Center(child: Image.asset('images/ic_launcher.png')),
            ),
          ),
        );
      },
    );
  }
}

