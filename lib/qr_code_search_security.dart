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
import 'home_screen_security.dart';
import 'login_screen.dart';
import 'models/getForm Models/getFormModel.dart';
import 'package:rnb/utils/_QRViewScreen.dart';


class SecuritySearch extends StatefulWidget {


  GetFormModel formModel;
  SecuritySearch(@required this.formModel) :assert(formModel != null);

  @override
  _HomeScreenSecurityState createState() => _HomeScreenSecurityState();
}

class _HomeScreenSecurityState extends State<SecuritySearch> {



  TextEditingController tempController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  Widget idCard = new SizedBox();

  String employeeId = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      idCard = cardId(widget.formModel);
    });
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
                ],
              ),
          Padding(
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
            ],
          ),
        ),
      ),
    );
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
          Text('RNB CARBIDES AND FERROALLOYS(P) LTD.',
            textAlign:TextAlign.center,style: TextStyle(
              fontSize: 15,
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
                      Text("DATE OF EXPIRY: "+model.partA.validity.year.toString()+'-'+model.partA.validity.month.toString()+'-'+model.partA.validity.day.toString(),style: TextStyle(fontSize: 16,fontFamily: "Inter",color: Colors.black),),
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
    ProgressDialog pd = new ProgressDialog(context);
    pd.style(message: "updating...");
    pd.show();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var id = sharedPreferences.getString("id");
    var jsonResponse = null;
    var data = {
      "employee_id": widget.formModel.partA.employeeId,
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
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    HomeScreenSecurity(),
              ), (
              Route<dynamic> route) => false);
        }
      }
    }
    else {
      showToast("Something went wrong. Please try again");
      print(response.body);
    }
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
