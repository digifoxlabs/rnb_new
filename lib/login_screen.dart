import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:rnb/verification_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen_admin.dart';
import 'home_screen_category.dart';
import 'home_screen_security.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({Key? key}) : super(key: key);

  @override
  _loginScreenState createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {

  bool _isLoading = false;
  final TextEditingController usernameController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xffECE9E6), Color(0xffFFFFFF)]),
        ),
        child: _isLoading ? Center(child: CircularProgressIndicator()) :  SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                child: Image.asset('images/ic_launcher.png'),
              ),
              Text(
                'LOGIN',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    height: 1),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                child: TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'Enter username',
                    helperStyle: TextStyle(
                        color: Color.fromRGBO(99, 100, 103, 1),
                        fontFamily: 'Inter',
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                            width: 2, color: Color(0xff1A203D))),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                            width: 2, color: Color(0xff1A203D))),
                    labelText: 'Username',
                    labelStyle: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        height: 1.3
                    ),

                ),
                  cursorColor: Color(0xff1A203D),
                  keyboardType: TextInputType.text,
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'Enter password',
                    helperStyle: TextStyle(
                      color: Color.fromRGBO(99, 100, 103, 1),
                      fontFamily: 'Inter',
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                            width: 2, color: Color(0xff1A203D))),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                            width: 2, color: Color(0xff1A203D))),
                    labelText: 'Password',
                    labelStyle: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        height: 1.3
                    ),

                  ),
                  cursorColor: Color(0xff1A203D),
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Log In', textAlign: TextAlign.left, style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'Poppins',
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        height: 0.7714285850524902
                    ),),
                    ClipOval(
                      child: Material(
                        color: Colors.black, // Button color
                        child: InkWell(
                          splashColor: Colors.blueGrey, // Splash color
                          onTap: () {
                            if (usernameController.text == "" || passwordController.text == "") {
                              showToast("Empty field");
                            } else {
                              setState(() {
                                _isLoading = true;
                              });
                              verify(usernameController.text,passwordController.text);
                            }
                          },
                          child: SizedBox(width: 64, height: 64, child: Icon(Icons.arrow_forward_ios,color: Colors.white,)),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  verify(String username,password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var data = {'user_id': username,'password': password};
    var jsonResponse = null;

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('admin:1234'));

    var response = await post(Uri.parse("https://rnb.digifoxlabs.com/api/auth/login"),
        body: data,
        headers: <String, String>{
          'authorization': basicAuth,
          'X-API-KEY':'rnb_app',
        });
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
        if (jsonResponse["status"] == false) {
          showToast(jsonResponse["message"]);
        } else {
          sharedPreferences.setString("username",jsonResponse["message"]["username"]);
          sharedPreferences.setString("role",jsonResponse["message"]["role"]);
          sharedPreferences.setString("id",jsonResponse["message"]["id"]);
          String role = jsonResponse["message"]["role"];
          switch(role) {
            case "admin":
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        HomeScreenAdmin(),
                  ), (
                  Route<dynamic> route) => false);
              break;
            case "subadmin":
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        HomeScreenCategory(),
                  ), (
                  Route<dynamic> route) => false);
              break;
            case "security":
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        HomeScreenSecurity(),
                  ), (
                  Route<dynamic> route) => false);
              break;
          }
          }
      }
    }
    else {
      showToast(json.decode(response.body)["message"]);
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }
    setState(() {
      _isLoading = false;
    });
  }

  showToast(String msg){
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}
