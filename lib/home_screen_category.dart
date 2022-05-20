import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rnb/active_labour.dart';
import 'package:rnb/blocs/card_labour_expire.dart';
import 'package:rnb/blocs/card_labour_subadmin.dart';
import 'package:rnb/employee_registration.dart';
import 'package:rnb/expering_more.dart';
import 'package:rnb/forms/form_A.dart';
import 'package:rnb/inactive_labour.dart';
import 'package:rnb/total_labour.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:rnb/utils/GlobalValues.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';
import 'login_screen.dart';
import 'models/getForm Models/getFormModel.dart';

class HomeScreenCategory extends StatefulWidget {
  const HomeScreenCategory({Key? key}) : super(key: key);

  @override
  _HomeScreenCategoryState createState() => _HomeScreenCategoryState();
}

class _HomeScreenCategoryState extends State<HomeScreenCategory> with SingleTickerProviderStateMixin{
  late Animation<double> _animation;
  late AnimationController _animationController;

  bool _isLoading = false;
  String name = "",id = "";
  getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("username")!= null){
      setState(() {
        name = sharedPreferences.getString("username")!;
        id = sharedPreferences.getString("id")!;
      });
    }
    _isLoading = true;
    var jsonResponse = null;
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('admin:1234'));
    var response = await get(Uri.parse("https://rnb.digifoxlabs.com/api/labour/myData?user_id=$id"),
        headers: <String, String>{
          'authorization': basicAuth,
          'X-API-KEY':'rnb_app',
        });
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        if (jsonResponse["status"] != false) {
          print(response.body);
          global_list = jsonResponse["message"];
        }
      }
    }
    else {
      print(response.body);
    }
    setState(() {
      _isLoading = false;
    });

  }

  @override
  void initState(){

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation = CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();

    getData();

  }
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child:  Padding(
                      padding: const EdgeInsets.fromLTRB(20, 60, 20, 0),
                      child: Text(
                        'Sub-admin',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color.fromRGBO(182, 132, 59, 1),
                            fontFamily: 'Poppins',
                            fontSize: 24,
                            letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.normal,
                            height: 0.9000000158945719),
                      ),
                    ),
                  ),
                  Align(alignment: Alignment.centerRight,child: btnLogout()),
                ],
              ),

              _isLoading ? Padding(
                padding: const EdgeInsets.all(28.0),
                child: Center(child: CircularProgressIndicator()),
              ) : ListView.builder(
                shrinkWrap: true,
                reverse: true,
                primary: false,
                itemBuilder: (context, position) {
                  return CardLabourSubadmin(GetFormModel.fromJson(global_list[position]));
                },
                itemCount: global_list.length,
              ),
            ],
          ),
        ),
      ),
       floatingActionButton: FabCategory()

    );
  }
  Container btnLogout() {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 60, 20, 0),
      child: RaisedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text("LOGOUT"),
              content: Text("Are you sure?"),
              actions: <Widget>[
                FlatButton(
                  onPressed: () async {
                    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                    sharedPreferences.clear();
                    FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (BuildContext context) => loginScreen()), (
                        Route<dynamic> route) => false);
                  },
                  child: Text("Logout"),
                ),
              ],
            ),
          );

        },
        elevation: 0.0,
        color: Colors.redAccent[400],
        child: Text("Logout", style: TextStyle(color: Colors.white,fontSize: 10,fontFamily: "Archivo",fontWeight: FontWeight.bold)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11.0)),
      ),
    );
  }
}

class FabCategory extends StatelessWidget {
  const FabCategory({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Color.fromRGBO(182, 132, 59, 1),
      onPressed: (){
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EmployeeReg()));
      },
      child: Icon(
        FontAwesomeIcons.plus,
        color: Colors.white,
      ),
    );
  }

}
