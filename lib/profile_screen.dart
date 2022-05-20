import 'dart:convert';
import 'dart:io';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:rnb/profile/address_info.dart';
import 'package:rnb/profile/document_info.dart';
import 'package:rnb/profile/family_info.dart';
import 'package:rnb/profile/personal_info.dart';
import 'package:http/http.dart';
import 'package:rnb/utils/PdfCreator.dart';
import 'package:rnb/utils/PdfViewerPage.dart';
import 'package:rnb/utils/formNTClear.dart';
import 'package:rnb/utils/formReg.dart';
import 'employee_update.dart';
import 'models/formModel.dart';
import 'models/getForm Models/getFormModel.dart';

class Profile extends StatefulWidget {
  GetFormModel formModel;
  Profile(@required this.formModel) :assert(formModel != null);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {


  String contr = "";

  check(String? cont){
    if(cont != null){
      contr = cont;
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(json.encode(widget.formModel));
    check(widget.formModel.partA.contractor.contractorName);
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 60, 0, 20),
                  child: Text(
                    'Profile',
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(widget.formModel.partD.photoUrl),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.formModel.partA.employeeName,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 1),
                                fontFamily: 'Inter',
                                fontSize: 20,
                                letterSpacing:
                                    0 /*percentages not used in flutter. defaulting to zero*/,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Place: '+widget.formModel.partC.city+", "+widget.formModel.partC.district,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 1),
                                fontFamily: 'Inter',
                                fontSize: 16,
                                letterSpacing:
                                    0 /*percentages not used in flutter. defaulting to zero*/,
                                fontWeight: FontWeight.normal,
                              ),
                              maxLines: 2,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Vaccinated:',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontFamily: 'Inter',
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          height: 1.0800000190734864),
                    ),
                    Spacer(),
                    Text(
                      widget.formModel.partA.vaccination.status,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: widget.formModel.partA.vaccination.status=='Yes'?Colors.green:Colors.red,
                          fontFamily: 'Inter',
                          fontSize: 20,
                          letterSpacing:
                          0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.normal,
                          height: 1.0800000190734864),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 2.0),
                      child: IconButton(
                        icon: Icon(Icons.info_outline),
                        onPressed: () {
                          if(widget.formModel.partA.vaccination.status=='Yes'){
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return  AlertDialog(
                                    content: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'Vaccination details',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Color.fromRGBO(0, 0, 0, 1),
                                                  fontFamily: 'Inter',
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  height: 1.0800000190734864),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  'First dose:',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(0, 0, 0, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.normal,
                                                      height: 1.0800000190734864),
                                                ),
                                                Text(
                                                  widget.formModel.partA.vaccination.firstDose,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(0, 0, 0, 1),
                                                      fontFamily: 'Inter',
                                                      letterSpacing:
                                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                                      fontWeight: FontWeight.normal,
                                                      height: 1.0800000190734864),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  'Second dose:',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(0, 0, 0, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.normal,
                                                      height: 1.0800000190734864),
                                                ),
                                                Text(
                                                  widget.formModel.partA.vaccination.secondDose,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(0, 0, 0, 1),
                                                      fontFamily: 'Inter',
                                                      letterSpacing:
                                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                                      fontWeight: FontWeight.normal,
                                                      height: 1.0800000190734864),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                              },
                            );
                          }
                        },
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Expiry date:',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontFamily: 'Inter',
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          height: 1.0800000190734864),
                    ),
                    Text(
                      widget.formModel.partA.validity.year.toString()+'/'+widget.formModel.partA.validity.month.toString()+'/'+widget.formModel.partA.validity.day.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontFamily: 'Inter',
                          fontSize: 20,
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.normal,
                          height: 1.0800000190734864),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(children: [
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: TextButton(style: TextButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PersonalInfo(widget.formModel.partA)));
                      }, child: Text('Personal Info', textAlign: TextAlign.center, style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontFamily: 'Inter',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          height: 1.350000023841858
                      ),)),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: TextButton(style: TextButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AddressInfo(widget.formModel.partC)));
                      }, child: Text('Address', textAlign: TextAlign.center, style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontFamily: 'Inter',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          height: 1.350000023841858
                      ),)),
                    ),
                  ),
                ],),

                SizedBox(height: 10,),

                Row(children: [
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: TextButton(style: TextButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => FamilyInfo(widget.formModel.partB)));
                      }, child: Text('Family Member', textAlign: TextAlign.center, style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontFamily: 'Inter',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          height: 1.350000023841858
                      ),)),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: TextButton(style: TextButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DocumentInfo(widget.formModel.partD)));
                      }, child: Text('Documents', textAlign: TextAlign.center, style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontFamily: 'Inter',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          height: 1.350000023841858
                      ),)),
                    ),
                  ),
                ],),
                SizedBox(height: 10,),

                Row(children: [
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: TextButton(style: TextButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => EmployeeUpdate(widget.formModel)));
                      }, child: Text('Update', textAlign: TextAlign.center, style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontFamily: 'Inter',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          height: 1.350000023841858
                      ),)),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: TextButton(style: TextButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),onPressed: (){
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: Text("DELETE"),
                            content: Text("Are you sure?"),
                            actions: <Widget>[
                              TextButton(onPressed: (){Navigator.of(context).pop();}, child:Text('cancel',style: TextStyle(color: Color.fromRGBO(182, 132, 59, 1)))),
                              FlatButton(
                                onPressed: () async {
                                  showToast("please wait...");
                                  var data = {
                                    "id": widget.formModel.partA.employeeId
                                  };
                                  var jsonResponse = null;
                                  String basicAuth = 'Basic ' + base64Encode(utf8.encode('admin:1234'));
                                  var response = await post(Uri.parse("http://api.rnbgroup.org/api/labour/delete"),
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
                                        Navigator.of(context).pop();
                                        showToast(jsonResponse["message"]);
                                      }
                                    }
                                  }
                                  else {
                                    showToast("Try again later.");
                                    print(response.body);
                                  }
                                  Navigator.of(context).pop();
                                },
                                child: Text("Delete",style: TextStyle(color: Colors.red),),
                              ),
                            ],
                          ),
                        );

                      }, child: Text('Delete', textAlign: TextAlign.center, style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontFamily: 'Inter',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          height: 1.350000023841858
                      ),)),
                    ),
                  ),
                ],),

                SizedBox(
                  width: double.infinity,
                  child: TextButton(style: TextButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                  ),onPressed: (){
                    TextEditingController dojController = TextEditingController();
                    TextEditingController validUptoController = TextEditingController();
                    dojController.text = widget.formModel.partA.doj.toString();
                    validUptoController.text = widget.formModel.partA.validity.year.toString()+'/'+widget.formModel.partA.validity.month.toString()+'/'+widget.formModel.partA.validity.day.toString();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return  AlertDialog(
                          content: Container(
                            width: 300,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:  const EdgeInsets.fromLTRB(
                                      0, 20, 0, 0),
                                  child: Center(
                                    child: Text("Extend validity",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                  ),),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0, 20, 0, 0),
                                  child:  DateTimePicker(
                                    controller: dojController,
                                    type: DateTimePickerType.date,
                                    firstDate: DateTime(1950),
                                    lastDate: DateTime.now(),
                                    decoration: InputDecoration(
                                      isDense: true,
                                      hintText: 'Enter date of joining',
                                      helperStyle: TextStyle(
                                        color: Color.fromRGBO(99, 100, 103, 1),
                                        fontFamily: 'Inter',
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      prefixStyle: TextStyle(fontSize: 14,fontFamily: 'Inter',fontWeight: FontWeight.bold),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                              width: 2, color: Color(0xff1A203D))),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                              width: 2, color: Color(0xff1A203D))),
                                      labelText: 'Date of joining *',
                                      labelStyle: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Inter',
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          height: 1.3
                                      ),
                                    ),
                                    cursorColor: Color(0xff1A203D),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter';
                                      }
                                      return null;
                                    },

                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0, 20, 0, 0),
                                  child: DateTimePicker(
                                    controller: validUptoController,
                                    type: DateTimePickerType.date,
                                    firstDate: DateTime(1950),
                                    lastDate: DateTime(3000),
                                    decoration: InputDecoration(
                                      isDense: true,
                                      hintText: 'Enter Expiry date',
                                      helperStyle: TextStyle(
                                        color: Color.fromRGBO(99, 100, 103, 1),
                                        fontFamily: 'Inter',
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      prefixStyle: TextStyle(fontSize: 14,fontFamily: 'Inter',fontWeight: FontWeight.bold),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                              width: 2, color: Color(0xff1A203D))),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                              width: 2, color: Color(0xff1A203D))),
                                      labelText: 'Expiry date *',
                                      labelStyle: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Inter',
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          height: 1.3
                                      ),
                                    ),
                                    cursorColor: Color(0xff1A203D),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter';
                                      }
                                      return null;
                                    },

                                  ),
                                ),
                              ],),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Done',style: TextStyle(color: Color.fromRGBO(182, 132, 59, 1)),),
                              onPressed: () async {
                                showToast("please wait...");
                                if(dojController.text != '' && validUptoController.text != '' ) {
                                  var data = {
                                    "employee_id": widget.formModel.partA.employeeId,
                                    "doj": dojController.text,
                                    "valid_upto": validUptoController.text
                                  };
                                  var jsonResponse = null;

                                  String basicAuth =
                                      'Basic ' + base64Encode(utf8.encode('admin:1234'));
                                  var response = await post(Uri.parse(
                                      "http://api.rnbgroup.org/api/Labour/updateValidity"),
                                      body: data,
                                      headers: <String, String>{
                                        'authorization': basicAuth,
                                        'X-API-KEY': 'rnb_app',
                                      });
                                  if (response.statusCode == 200) {
                                    jsonResponse = json.decode(response.body);
                                    if (jsonResponse != null) {
                                      if (jsonResponse["status"] == false) {
                                        showToast("Failed. try again");
                                      } else {
                                        print(response.body);
                                        showToast("Updated successfully");
                                      }
                                    }
                                  }
                                  else {
                                    print(response.body);
                                    showToast("Failed. try again");
                                  }
                                  Navigator.of(context).pop();
                                }
                                else{
                                  showToast("empty field");
                                }
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }, child: Text('Extend Validity', textAlign: TextAlign.center, style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontFamily: 'Inter',
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      height: 1.350000023841858
                  ),)),
                ),
                SizedBox(height: 10,),

                Text(
                  'PDFs',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      height: 1.0800000190734864),
                ),
                Row(children: [
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: TextButton(style: TextButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                      ),onPressed: (){
                        formLabourReg(widget.formModel,context);
                      }, child: Text('Labour Registration PDF', textAlign: TextAlign.center, style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontFamily: 'Inter',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          height: 1.350000023841858
                      ),)),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: TextButton(style: TextButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                      ),onPressed: (){
                        formNTClear(widget.formModel,context);
                      }, child: Text('N.T. Employee Clearance Certificate', textAlign: TextAlign.center, style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontFamily: 'Inter',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          height: 1.350000023841858
                      ),)),
                    ),
                  ),
                ],),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'ID Card',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color.fromRGBO(182, 132, 59, 1),
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            height: 1.0800000190734864),
                      ),
                      IconButton(onPressed: (){
                        reportView(context,widget.formModel);
                      }, icon: Icon(Icons.share)),
                    ],
                  ),
                ),
                // TODO: HERE WILL BE THE ACTIVITIES IN CARD
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: cardId(widget.formModel),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget cardId(GetFormModel model){
    getImages(model.partD.photoUrl);
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
                padding: const EdgeInsets.fromLTRB(0, 18, 18, 0),
                child: CircleAvatar(radius: 40 ,backgroundImage: NetworkImage(model.partD.photoUrl),),

              ),
            ],
          ),
          Image.asset("images/ic_launcher.png",height: 120,),
          Text('RNB CARBIDES AND FERRO ALLOYS PVT LTD.',
            textAlign:TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
              fontFamily: "Inter"
          ),),
          SizedBox(height: 20,),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("ID                                        : ",style: TextStyle(fontSize: 12,fontFamily: "Inter",color: Colors.black),),
                          Expanded(child: Text(model.partA.employeeId,style: TextStyle(fontSize: 12,fontFamily: "Inter",color: Colors.black),)),

                        ],
                      ),
                      SizedBox(height: 6,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("NAME                                 : ",style: TextStyle(fontSize: 12,fontFamily: "Inter",color: Colors.black),),
                          Expanded(child: Text(model.partA.employeeName,style: TextStyle(fontSize: 12,fontFamily: "Inter",color: Colors.black),)),

                        ],
                      ),
                      SizedBox(height: 6,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("ADDRESS                          : ",style: TextStyle(fontSize: 12,fontFamily: "Inter",color: Colors.black),),
                          Expanded(child: Text(model.partC.permanentAddress,style: TextStyle(fontSize: 12,fontFamily: "Inter",color: Colors.black),)),

                        ],
                      ),
                      SizedBox(height: 6,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("DESIGNATION                  : ",style: TextStyle(fontSize: 12,fontFamily: "Inter",color: Colors.black),),
                          Expanded(child: Text(model.partA.designation,style: TextStyle(fontSize: 12,fontFamily: "Inter",color: Colors.black),)),

                        ],
                      ),
                      SizedBox(height: 6,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("PHONE NO.                       : ",style: TextStyle(fontSize: 12,fontFamily: "Inter",color: Colors.black),),
                          Expanded(child: Text(model.partA.mobileNo,style: TextStyle(fontSize: 12,fontFamily: "Inter",color: Colors.black),)),

                        ],
                      ),
                      SizedBox(height: 6,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("CONTRACTOR NAME     : ",style: TextStyle(fontSize: 12,fontFamily: "Inter",color: Colors.black),),
                          Expanded(child: Text(contr,style: TextStyle(fontSize: 12,fontFamily: "Inter",color: Colors.black),)),

                        ],
                      ),
                      SizedBox(height: 6,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("BLOOD GROUP                : ",style: TextStyle(fontSize: 12,fontFamily: "Inter",color: Colors.black),),
                          Expanded(child: Text(model.partA.bloodGroup,style: TextStyle(fontSize: 12,fontFamily: "Inter",color: Colors.black),)),

                        ],
                      ),
                      SizedBox(height: 6,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("EMERGENCY CONTACT: ",style: TextStyle(fontSize: 12,fontFamily: "Inter",color: Colors.black),),
                          Expanded(child: Text(model.partA.emergencyPhoneNo,style: TextStyle(fontSize: 12,fontFamily: "Inter",color: Colors.black),)),

                        ],
                      ),
                      SizedBox(height: 6,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("DATE OF ISSUE               : ",style: TextStyle(fontSize: 12,fontFamily: "Inter",color: Colors.black),),
                          Expanded(child: Text(model.partA.doj.year.toString()+'/'+model.partA.doj.month.toString()+'/'+model.partA.doj.day.toString(),style: TextStyle(fontSize: 12,fontFamily: "Inter",color: Colors.black),)),

                        ],
                      ),
                      SizedBox(height: 6,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("DATE OF EXPIRY             : ",style: TextStyle(fontSize: 12,fontFamily: "Inter",color: Colors.black),),
                          Expanded(child: Text(model.partA.validity.year.toString()+'/'+model.partA.validity.month.toString()+'/'+model.partA.validity.day.toString(),style: TextStyle(fontSize: 12,fontFamily: "Inter",color: Colors.black),)),

                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 6,),
          Text("Office & Works : Umiam Industrial Area,Umiam - 793103.\nDist Ri Bhoi.Meghalaya.India.\nM  +91 8132953936  E Ferro@Rnbgroup.org\nwww.rnbgroup.org",textAlign:TextAlign.center,style: TextStyle(fontSize: 12,fontFamily: "Inter",color: Colors.black),),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: QrImage(
                  data: model.partA.employeeId,
                  version: QrVersions.auto,
                  size: 70.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
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
