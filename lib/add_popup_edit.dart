import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:rnb/utils/GlobalValues.dart';
import 'package:select_form_field/select_form_field.dart';
class AddPopupEdit extends StatefulWidget {


  String role,name,id,status,userId,password;
  AddPopupEdit(@required this.role,
      @required this.name,
      @required this.id,
      @required this.status,
  @required this.userId,
  @required this.password);


  @override
  _AddPopupState createState() => _AddPopupState();
}

class _AddPopupState extends State<AddPopupEdit> {

  TextEditingController controllerName = new TextEditingController();
  TextEditingController controllerUserId= new TextEditingController();
  TextEditingController controllerPassword = new TextEditingController();
  TextEditingController controllerStatus = new TextEditingController();

  final List<Map<String, dynamic>> _itemsStatus = [
    {
      'value': '1',
      'label': 'Active',
    },
    {
      'value': '0',
      'label': 'not active',
    },
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controllerName.text = widget.name;
    controllerUserId.text = widget.userId;
    controllerPassword.text = widget.password;
    controllerStatus.text = widget.status;
  }

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
                  child: Text("Edit "+widget.role,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                ),),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    0, 20, 0, 0),
                child: TextFormField(
                  controller: controllerName,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'Name',
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
                    labelText: 'Name *',
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                      0, 20, 0, 0),
                  child: TextFormField(
                    controller: controllerUserId,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'User ID',
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
                      labelText: 'User ID *',
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                      0, 20, 0, 0),
                  child: TextFormField(
                    controller: controllerPassword,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'Password',
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
                      labelText: 'Password *',
                      labelStyle: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Inter',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          height: 1.3),
                    ),
                    cursorColor: Color(0xff1A203D),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter';
                      }
                      return null;
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: SelectFormField(
                    controller: controllerStatus,
                    items: _itemsStatus,
                    maxLengthEnforced: true,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'Status',
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
                      labelText: 'Status *',
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

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select';
                      }
                      return null;
                    },

                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    TextButton(
                      child: const Text('Delete',style: TextStyle(color: Colors.red),),
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: Text("DELETE"),
                            content: Text("Are you sure?"),
                            actions: <Widget>[
                              TextButton(onPressed: (){Navigator.of(context).pop();}, child:Text('Cancel',style: TextStyle(color: Color.fromRGBO(182, 132, 59, 1)))),
                              FlatButton(
                                onPressed: () async {
                                  showToast("please wait...");
                                  var data = {
                                    "id": widget.id
                                  };
                                  var jsonResponse = null;

                                  String basicAuth =
                                      'Basic ' + base64Encode(utf8.encode('admin:1234'));
                                  var response = await post(Uri.parse(
                                      "http://api.rnbgroup.org/api/employee/delete"),
                                      body: data,
                                      headers: <String, String>{
                                        'authorization': basicAuth,
                                        'X-API-KEY': 'rnb_app',
                                      });
                                  if (response.statusCode == 200) {
                                    jsonResponse = json.decode(response.body);
                                    if (jsonResponse != null) {
                                      if (jsonResponse["status"] == false) {
                                        showToast(jsonResponse["message"]);
                                      } else {
                                        print(response.body);
                                        setState(() {
                                          global_list.removeWhere((element) => (element["id"] == widget.id));
                                        });
                                        print(global_list.toString());
                                        showToast(jsonResponse["message"]);
                                      }
                                    }
                                  }
                                  else {
                                    print(response.body);
                                    showToast(jsonResponse["message"]);
                                  }
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                },
                                child: Text("Delete",style: TextStyle(color: Colors.red),),
                              ),
                            ],
                          ),
                        );

                      },
                    ),
                    Spacer(),
                    TextButton(
                      child: const Text('Done',style: TextStyle(color: Color.fromRGBO(182, 132, 59, 1)),),
                      onPressed: () async {
                        showToast("please wait...");
                        if(controllerName.text != '' && controllerUserId.text != '' && controllerPassword.text != '' && widget.role != ''  && controllerStatus.text != '') {

                          print(controllerStatus.text);
                          var data = {
                            "name": controllerName.text,
                            "user_id": controllerUserId.text,
                            "role": widget.role,
                            "password": controllerPassword.text,
                            "id": widget.id,
                            "status": controllerStatus.text,
                          };
                          var jsonResponse = null;

                          String basicAuth =
                              'Basic ' + base64Encode(utf8.encode('admin:1234'));
                          var response = await post(Uri.parse(
                              "https://rnb.digifoxlabs.com/api/employee/update"),
                              body: data,
                              headers: <String, String>{
                                'authorization': basicAuth,
                                'X-API-KEY': 'rnb_app',
                              });
                          if (response.statusCode == 200) {
                            jsonResponse = json.decode(response.body);
                            if (jsonResponse != null) {
                              if (jsonResponse["status"] == false) {
                                showToast(jsonResponse["message"]);
                              } else {
                                global_list.elementAt(global_list.indexWhere((element)
                                => (element["id"] == widget.id)))["username"] = controllerName.text;
                                global_list.elementAt(global_list.indexWhere((element)
                                => (element["id"] == widget.id)))["user_id"] =controllerUserId.text;
                                global_list.elementAt(global_list.indexWhere((element)
                                => (element["id"] == widget.id)))["password"] =controllerPassword.text;
                                global_list.elementAt(global_list.indexWhere((element)
                                => (element["id"] == widget.id)))["role"] = widget.role;
                                global_list.elementAt(global_list.indexWhere((element)
                                => (element["id"] == widget.id)))["id"] = widget.id;
                                global_list.elementAt(global_list.indexWhere((element)
                                => (element["id"] == widget.id)))["status"] = widget.status;
                                showToast(jsonResponse["message"]);
                              }
                            }
                          }
                          else {
                            print(response.body);
                            showToast(jsonResponse["message"]);
                          }
                          Navigator.of(context).pop();
                        }
                        else{
                          showToast("empty field");
                        }
                      },
                    ),
                  ],
                )
            ],),
          ),
          actions: <Widget>[
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
