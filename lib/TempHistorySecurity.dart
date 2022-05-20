import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rnb/models/tempHistoryModel.dart';
import 'package:rnb/utils/GlobalValues.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'edit_popup_job.dart';
class TempHistorySecurity extends StatefulWidget {
  const TempHistorySecurity({Key? key}) : super(key: key);

  @override
  _NoOfEmployeesState createState() => _NoOfEmployeesState();
}

bool _isLoading = true;
Widget container = new Container(child: Text(""),);
class _NoOfEmployeesState extends State<TempHistorySecurity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(
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
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 60, 20,0),
                child: Text(
                  'History',
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
              _isLoading ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: CircularProgressIndicator()),
              ) : container,
            ],
          ),
        ),
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var id = sharedPreferences.getString("id");
    print(id);
    _isLoading = true;
    var jsonResponse = null;
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('admin:1234'));
    var response = await get(Uri.parse("https://rnb.digifoxlabs.com/api/security/records?id=$id"),
        headers: <String, String>{
          'authorization': basicAuth,
          'X-API-KEY':'rnb_app',
        });
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        if (jsonResponse["status"] != false) {
          print(response.body);
          container = ListView.builder(
            shrinkWrap: true,
            reverse: true,
            primary: false,
            itemBuilder: (context, position) {
              return cardHistory(TempHistoryModel.fromJson(jsonResponse['message'][position]["data"]));
            },
            itemCount: jsonResponse['message'].length,
          );
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

  Widget cardHistory(TempHistoryModel model){
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          width: double.infinity,
          child:Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(padding:EdgeInsets.all(3.0),color: Colors.orange,child: Text(model.dated.year.toString()+'-'+model.dated.month.toString()+'-'+model.dated.day.toString(),
                      style: TextStyle(color: Colors.white),)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(flex: 0,child: CircleAvatar(radius:30,backgroundImage:  NetworkImage(model.photoUrl))),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(model.employeeName, textAlign: TextAlign.left, style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontFamily: 'Inter',
                              fontSize: 16,
                              letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.bold,
                            ),
                              maxLines: 2,),
                            Text(model.designation, textAlign: TextAlign.left, style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontFamily: 'Inter',
                              fontSize: 16,
                              letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.normal,
                            ),
                              maxLines: 2,)
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: new BoxDecoration(
                            color: Colors.red,
                            borderRadius: new BorderRadius.only(
                              bottomRight: const Radius.circular(20.0),
                              topRight: const Radius.circular(20.0),
                            )
                        ),
                        child: Center(
                          child: Text(model.temperature+"ºF", textAlign: TextAlign.left, style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontFamily: 'Inter',
                              fontSize: 16,
                              letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.normal,
                              height: 1.350000023841858
                          ),),
                        ),
                      ),
                    )

                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
