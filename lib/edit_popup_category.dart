import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:rnb/utils/GlobalValues.dart';
class EditPopupCategory extends StatefulWidget {


  String validity,name,id;
  EditPopupCategory(
      @required this.name,
      @required this.id,
      @required this.validity);


  @override
  _AddPopupState createState() => _AddPopupState();
}

class _AddPopupState extends State<EditPopupCategory> {

  TextEditingController controllerName = new TextEditingController();
  TextEditingController controllerValidity = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controllerName.text = widget.name;
    controllerValidity.text = widget.validity;
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
                  child: Text("Edit "+widget.name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
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
                  controller: controllerValidity,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'Validity',
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
                    labelText: 'Validity(in days). *',
                    labelStyle: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        height: 1.3),
                  ),
                  cursorColor: Color(0xff1A203D),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter';
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
                                  if(controllerName.text != '' && controllerValidity.text != '') {
                                    var data = {
                                      "id": widget.id
                                    };
                                    var jsonResponse = null;

                                    String basicAuth =
                                        'Basic ' + base64Encode(utf8.encode('admin:1234'));
                                    var response = await post(Uri.parse(
                                        "https://rnb.digifoxlabs.com/api/category/delete"),
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
                                            global_list.removeWhere((element) => (element["cat_id"] == widget.id));
                                          });
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
                                  }
                                  else{
                                    showToast("empty field");
                                  }
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
                        if(controllerName.text != '' && controllerValidity.text != '') {
                          var data = {
                            "name": controllerName.text,
                            "validity": controllerValidity.text,
                            "id": widget.id
                          };
                          var jsonResponse = null;

                          String basicAuth =
                              'Basic ' + base64Encode(utf8.encode('admin:1234'));
                          var response = await post(Uri.parse(
                              "https://rnb.digifoxlabs.com/api/category/update"),
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
                                => (element["cat_id"] == widget.id)))["cat_id"] = widget.id;
                                global_list.elementAt(global_list.indexWhere((element)
                                => (element["cat_id"] == widget.id)))["cat_name"] =controllerName.text;
                                global_list.elementAt(global_list.indexWhere((element)
                                => (element["cat_id"] == widget.id)))["cat_validity"] = controllerValidity.text;
                                print(response.body);
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
