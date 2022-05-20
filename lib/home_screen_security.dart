import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';

import 'TempHistorySecurity.dart';
import 'login_screen.dart';
import 'models/getForm Models/getFormModel.dart';
import 'package:rnb/utils/_QRViewScreen.dart';


class HomeScreenSecurity extends StatefulWidget {
  const HomeScreenSecurity({Key? key}) : super(key: key);



  @override
  _HomeScreenSecurityState createState() => _HomeScreenSecurityState();
}

class _HomeScreenSecurityState extends State<HomeScreenSecurity> {

  bool viewVisible = false ;

  void showWidget(){
    setState(() {
      viewVisible = true ;
    });
  }

  void hideWidget(){
    setState(() {
      viewVisible = false ;
    });
  }

  TextEditingController tempController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  Widget idCard = new SizedBox();

  String employeeId = '';
  late ProgressDialog pd;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pd = new ProgressDialog(context);
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
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 60, 20, 0),
                      child: Text(
                        'Security',
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
                  Align(alignment: Alignment.centerRight, child: btnLogout()),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                        decoration: InputDecoration(
                          fillColor: Color(0xbec4c4c4),
                          filled: true,
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xffB6843B),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          suffixIcon: InkWell(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => QRViewScreen()));
                            },
                            child: Icon(
                              Icons.qr_code,
                              color: Color(0xffB6843B),
                            ),
                          ),
                          border: InputBorder.none,
                          hintText: "Search here...",
                          contentPadding: const EdgeInsets.only(
                            left: 16,
                            right: 20,
                            top: 14,
                            bottom: 14,
                          ),
                        ),
                        cursorColor: Color(0xffB6843B),
                      ),
                    ),
                    IconButton(onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TempHistorySecurity(),
                          ));
                      }, icon: Icon(Icons.history,color: Colors.blue,)),
                  ],
                ),
              ),
              Center(
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Color(0xffB6843B),
                      padding:
                          EdgeInsets.symmetric(horizontal: 60, vertical: 10)),
                  onPressed: (){
                    if(searchController.text != ''){
                      searchId(searchController.text);
                    }else{
                      showToast("Empty Field.");
                    }
                  },
                  child: Text(
                    'Search',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
          Visibility(
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            visible: viewVisible,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                children: [
                  Neumorphic(
                    style: NeumorphicStyle(
                        shape: NeumorphicShape.concave,
                        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                        depth: 10,
                        intensity: .7,
                        surfaceIntensity: 0.5,
                        lightSource: LightSource.topLeft,
                        color: Colors.grey),
                    child: Container(
                        width: double.infinity,
                        color: Colors.white,
                        child: idCard, ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 16,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 60),
                        child: TextField(
                          controller: tempController,
                          decoration: InputDecoration(
                              labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Inter',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  height: 1.3
                              ),
                              hintText: 'Enter Temperature',
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                      width: 2, color: Color(0xff1A203D))),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                      width: 2, color: Color(0xff1A203D))),
                              suffixText: 'ºF',suffixStyle: TextStyle(fontSize: 16)
                          ),
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Center(
                        child: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Color(0xffB6843B),
                              padding:
                              EdgeInsets.symmetric(horizontal: 60, vertical: 10)),
                          onPressed: (){
                            if(tempController.text != ''){
                              submitTemp(tempController.text);
                            }else{
                              showToast("Empty Field.");
                            }
                          },
                          child: Text(
                            'Submit',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 12,
                      ),

                    ],

                  )
                ],
              ),
            ),
          ),
            ],
          ),
        ),
      ),
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
                    SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();
                    sharedPreferences.clear();
                    FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (BuildContext context) => loginScreen()),
                        (Route<dynamic> route) => false);
                  },
                  child: Text("Logout"),
                ),
              ],
            ),
          );
        },
        elevation: 0.0,
        color: Colors.redAccent[400],
        child: Text("Logout",
            style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontFamily: "Archivo",
                fontWeight: FontWeight.bold)),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(11.0)),
      ),
    );
  }

  searchId(var txtId) async {
    pd.style(message: "Searching...");
    pd.show();
    var jsonResponse = null;
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('admin:1234'));
    var response = await get(Uri.parse("https://rnb.digifoxlabs.com/api/labour/view?id=$txtId"),
        headers: <String, String>{
          'authorization': basicAuth,
          'X-API-KEY':'rnb_app',
        });
    jsonResponse = json.decode(response.body);
    if (response.statusCode == 200) {
      if (jsonResponse != null) {
        if (jsonResponse["status"] != false) {
          print(response.body);
          GetFormModel model = GetFormModel.fromJson(jsonResponse['message'][0]);
          setState(() {
            employeeId = model.partA.employeeId;
            idCard = cardId(model);
            (context as Element).markNeedsBuild();
            showWidget();
          });
        }
      }
    }
    else {
      showToast(jsonResponse["message"]);
      print(response.body);
    }
    pd.hide();
  }

  Widget cardId(GetFormModel model){
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
              image: AssetImage('images/background.png'),
              fit: BoxFit.cover
          )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 12,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("images/ic_launcher.png",height: 100,),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Text('R&B Enterprise',style: TextStyle(
              fontSize: 24,
              color: Colors.black,
              fontFamily: "Inter"
          ),),
          SizedBox(height: 30,),
          CircleAvatar(radius: 50 ,backgroundImage: NetworkImage(model.partD.photoUrl),),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("NAME: "+model.partA.employeeName,style: TextStyle(fontSize: 16,fontFamily: "Inter",color: Colors.black),),
                      SizedBox(height: 6,),
                      Text("ADDRESS: "+model.partC.permanentAddress,style: TextStyle(fontSize: 16,fontFamily: "Inter",color: Colors.black),),
                      SizedBox(height: 6,),
                      Text("DESIGNATION: "+model.partA.designation,style: TextStyle(fontSize: 16,fontFamily: "Inter",color: Colors.black),),
                      SizedBox(height: 6,),
                      Text("PHONE NO.: "+model.partA.mobileNo,style: TextStyle(fontSize: 16,fontFamily: "Inter",color: Colors.black),),
                      SizedBox(height: 6,),
                      Text("CONTRACTOR NAME: "+model.partA.contractor.contractorName,style: TextStyle(fontSize: 16,fontFamily: "Inter",color: Colors.black),),
                      SizedBox(height: 6,),
                      Text("BLOOD GROUP: "+model.partA.bloodGroup,style: TextStyle(fontSize: 16,fontFamily: "Inter",color: Colors.black),),
                      SizedBox(height: 6,),
                      Text("EMERGENCY CONTACT: "+model.partA.emergencyPhoneNo,style: TextStyle(fontSize: 16,fontFamily: "Inter",color: Colors.black),),
                      SizedBox(height: 6,),
                      Text("DATE OF ISSUE: "+model.partA.doj.year.toString()+'-'+model.partA.doj.month.toString()+'-'+model.partA.doj.day.toString(),style: TextStyle(fontSize: 16,fontFamily: "Inter",color: Colors.black),),
                      SizedBox(height: 6,),
                      Text("DATE OF EXPIRY: "+model.partA.validity.year.toString()+'/'+model.partA.validity.month.toString()+'/'+model.partA.validity.day.toString(),style: TextStyle(fontSize: 16,fontFamily: "Inter",color: Colors.black),),
                      SizedBox(height: 80,),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  submitTemp(var temp) async {
    pd.style(message: "Updating...");
    pd.show();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var id = sharedPreferences.getString("id");
    var jsonResponse = null;
    var data = {
      "employee_id": employeeId,
      "temperature":temp,
      "posted_by":id
    };
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('admin:1234'));
    var response = await post(Uri.parse("https://rnb.digifoxlabs.com/api/security/entry"),
        body: data,
        headers: <String, String>{
          'authorization': basicAuth,
          'X-API-KEY':'rnb_app',
        });
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        if (jsonResponse["status"] != false) {
          print(response.body);
          showToast(jsonResponse['message']);
          setState(() {
            idCard = SizedBox();
            searchController.text = '';
            tempController.text = '';
            (context as Element).markNeedsBuild();
            hideWidget();
          });
        }
      }
    }
    else {
      showToast("Something went wrong. Please try again");
      print(response.body);
    }
    pd.hide();
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
