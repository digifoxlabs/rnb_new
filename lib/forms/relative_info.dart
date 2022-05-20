import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rnb/forms/formB.dart';
import 'package:rnb/models/NextOfKinModel.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:rnb/utils/GlobalValues.dart' as globals;
class relative extends StatefulWidget {
  const relative({Key? key}) : super(key: key);

  @override
  _KidState createState() => _KidState();
}

class _KidState extends State<relative> {
  TextEditingController controllerName = new TextEditingController();
  TextEditingController controllerAddress = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        child: AlertDialog(
          content: Container(
            width: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: TextFormField(
                    controller: controllerName,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'Name',
                      helperStyle: TextStyle(
                        color: Color.fromRGBO(99, 100, 103, 1),
                        fontFamily: 'Inter',
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                      prefixStyle: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              BorderSide(width: 2, color: Color(0xff1A203D))),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              BorderSide(width: 2, color: Color(0xff1A203D))),
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
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: TextFormField(
                    controller: controllerAddress,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'Address',
                      helperStyle: TextStyle(
                        color: Color.fromRGBO(99, 100, 103, 1),
                        fontFamily: 'Inter',
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                      prefixStyle: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              BorderSide(width: 2, color: Color(0xff1A203D))),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              BorderSide(width: 2, color: Color(0xff1A203D))),
                      labelText: 'Address *',
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

              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Done',
                style: TextStyle(color: Color.fromRGBO(182, 132, 59, 1)),
              ),
              onPressed: () {
                if(controllerName.text != "" && controllerAddress.text != ""){
                  globals.relativeModel = NextOfKin(name: controllerName.text, address: controllerAddress.text);
                  globals.controllerRelativeInMegh.text = controllerName.text+", "+controllerAddress.text;
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
