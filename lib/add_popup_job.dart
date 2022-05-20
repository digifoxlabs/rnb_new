import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
class AddPopupJob extends StatefulWidget {

  @override
  _AddPopupState createState() => _AddPopupState();
}

class _AddPopupState extends State<AddPopupJob> {

  TextEditingController controllerName = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        child: AlertDialog(
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
                  child: Text("Create job",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                ),),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    0, 20, 0, 0),
                child: TextFormField(
                  controller: controllerName,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'Job name',
                    helperStyle: TextStyle(
                      color:
                      Color.fromRGBO(99, 100, 103, 1),
                      fontFamily: 'Inter',
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                    prefixStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold),
                    focusedBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                            width: 2,
                            color: Color(0xff1A203D))),
                    enabledBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                            width: 2,
                            color: Color(0xff1A203D))),
                    labelText: 'Job name *',
                    labelStyle: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        height: 1.3),
                  ),
                  cursorColor: Color(0xff1A203D),
                  keyboardType: TextInputType.text,
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
                if(controllerName.text != '' ) {
                    var data = {
                      "name": controllerName.text,
                    };
                    var jsonResponse = null;

                    String basicAuth =
                        'Basic ' + base64Encode(utf8.encode('admin:1234'));
                    var response = await post(Uri.parse(
                        "https://rnb.digifoxlabs.com/api/job/create"),
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
                          showToast("New job created successfully");
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
        ),
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
