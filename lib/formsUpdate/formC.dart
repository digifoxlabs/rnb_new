import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/services.dart';
import 'package:rnb/forms/formB.dart';
import 'package:rnb/home_screen_category.dart';
import 'package:rnb/models/getForm%20Models/getPartC.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:rnb/utils/GlobalValues.dart' as globals;


class FormCUpdate extends StatefulWidget {
  final VoidCallback onfrontPress,onbackPress;
  final PartCGet model;
  const FormCUpdate({Key? key,required this.onfrontPress,required this.onbackPress,required this.model}) : super(key: key);

  @override
  _AddressFormState createState() => _AddressFormState();
}

class _AddressFormState extends State<FormCUpdate> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
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
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Text(
                  'Address',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Color.fromRGBO(182, 132, 59, 1),
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      height: 1.0800000190734864),
                ),
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: TextFormField(
                          controller: globals.controllerPermanentAddress,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'EnterPermanent / Postal Address',
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
                            labelText: 'Permanent / Postal Address *',
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
                              return 'Please enter';
                            }
                            return null;
                          },

                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: TextFormField(
                          controller: globals.controllerDistrict,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'Enter District',
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
                            labelText: 'District *',
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
                              return 'Please enter';
                            }
                            return null;
                          },

                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: TextFormField(
                          controller: globals.controllerCity,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'Enter City/Town',
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
                            labelText: 'City/Town *',
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
                              return 'Please enter';
                            }
                            return null;
                          },

                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: TextFormField(
                          controller: globals.controllerState,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'Enter State',
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
                            labelText: 'State *',
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
                              return 'Please enter';
                            }
                            return null;
                          },

                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: TextFormField(
                          controller: globals.controllerPinCode,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'Enter Pin code',
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
                            labelText: 'Pin code *',
                            labelStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1.3
                            ),
                          ),
                          cursorColor: Color(0xff1A203D),
                          keyboardType: TextInputType.number,

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter';
                            }
                            return null;
                          },

                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: TextFormField(
                          controller: globals.controllerPostalAddress,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'Enter Postal Address in Meghalaya',
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
                            labelText: 'Postal Address in Meghalaya (if any)',
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
                              return 'Please enter';
                            }
                            return null;
                          },

                        ),
                      ),

                    ],
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                    child: ClipOval(
                      child: Material(
                        color: Colors.black, // Button color
                        child: InkWell(
                          splashColor: Colors.blueGrey, // Splash color
                          onTap: widget.onbackPress,
                          child: SizedBox(width: 64, height: 64, child: Icon(Icons.arrow_back_ios,color: Colors.white,)),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                    child: ClipOval(
                      child: Material(
                        color: Colors.black, // Button color
                        child: InkWell(
                          splashColor: Colors.blueGrey, // Splash color
                          onTap: widget.onfrontPress,
                          child: SizedBox(width: 64, height: 64, child: Icon(Icons.arrow_forward_ios,color: Colors.white,)),
                        ),
                      ),
                    ),
                  ),


                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


